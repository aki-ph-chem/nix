{ inputs, pkgs, ... }:
let
  # yomiyasu's SKILL.md assumes `python3` is on PATH and uses
  # ${CLAUDE_SKILL_DIR} as a placeholder. Rewrite both at build time so the
  # skill works without changing the global PATH and without relying on the
  # agent to expand the placeholder. The source path is target-independent,
  # unlike the per-target install directory.
  yomiyasuSrc = "${inputs.yomiyasu-skills}/skills/yomiyasu";
  python3 = "${pkgs.python3}/bin/python3";
in
{
  imports = [ inputs.agent-skills.homeManagerModules.default ];

  programs.agent-skills = {
    enable = true;

    sources = {
      mattpocock = {
        path = inputs.mattpocock-skills;
        subdir = "skills";
      };
      yomiyasu = {
        path = inputs.yomiyasu-skills;
        subdir = "skills";
      };
      ponytail = {
        path = inputs.ponytail-skills;
        subdir = "skills";
      };
    };

    skills.enable = [
      "productivity/grilling"
      "ponytail"
      "ponytail-review"
      "ponytail-audit"
      "ponytail-debt"
      "ponytail-gain"
      "ponytail-help"
    ];

    # yomiyasu must be explicit (not in skills.enable) because only explicit
    # skills can transform SKILL.md. Embedding the interpreter path also makes
    # the bundle depend on pkgs.python3, so it cannot be garbage-collected.
    skills.explicit.yomiyasu = {
      from = "yomiyasu";
      path = "yomiyasu";
      transform = { original, ... }:
        builtins.replaceStrings
          [ "python3" "\${CLAUDE_SKILL_DIR}" ]
          [ python3 yomiyasuSrc ]
          original;
    };

    # $HOME/.agents/skills is discovered by OpenCode as a global
    # compatibility source. Keep ~/.config/opencode/skills untouched.
    targets.agents.enable = true;
  };
}

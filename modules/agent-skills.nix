{ inputs, ... }:
{
  imports = [ inputs.agent-skills.homeManagerModules.default ];

  programs.agent-skills = {
    enable = true;

    sources.mattpocock = {
      path = inputs.mattpocock-skills;
      subdir = "skills";
    };

    skills.enable = [ "productivity/grilling" ];

    # $HOME/.agents/skills is discovered by OpenCode as a global
    # compatibility source. Keep ~/.config/opencode/skills untouched.
    targets.agents.enable = true;
  };
}

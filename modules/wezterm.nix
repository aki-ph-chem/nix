{ dotfiles, ... }:
{

  home.file = {
    ".wezterm.lua" = {
      source = "${dotfiles}/wezterm/.wezterm.lua";
    };
  };

}

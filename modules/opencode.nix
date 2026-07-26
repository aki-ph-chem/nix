{
  config,
  pkgs,
  ...
}:
{
  home.packages = [
    pkgs.opencode
  ];
}

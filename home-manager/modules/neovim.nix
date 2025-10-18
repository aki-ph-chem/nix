{
  config,
  pkgs,
  ...
}:

let
  nvimConfigPath = "${config.home.homeDirectory}/neovim-config/nvim";
  skkDict = pkgs.libskk;
  skkDictPath = "${skkDict}/share/skk/SKK-JISYO.L";
  traceSkkDictPath = builtins.trace ("DEBUG: skkDictPath " + skkDictPath) skkDictPath;
in
{

  home.file.".config/nvim" = {
    source = config.lib.file.mkOutOfStoreSymlink "${nvimConfigPath}";
    recursive = true;
  };

  home.packages = [
    pkgs.libskk
  ];

  home.sessionVariables = {
    SKK_JISYO_L_PATH = traceSkkDictPath;
  };

  programs.neovim = {
    enable = true;
    extraPackages = [
      # Language Servers
      pkgs.gopls
      pkgs.lua-language-server
      ## Language server for Nix Language
      pkgs.nil
      ## ty
      pkgs.ty
      ## Language server for Tex(LaTex)
      pkgs.texlab
      ## Language server for Typst
      pkgs.tinymist
      # fromatter
      ## emf-langserver
      pkgs.efm-langserver
      ## fomatter for Lua
      pkgs.stylua
      ## formatter for json
      pkgs.jq
      ## fomatter for Nix Language
      pkgs.nixfmt-rfc-style
      ## Language server for Markdown
      pkgs.markdown-oxide
      # others
      ## tree-sitter
      pkgs.tree-sitter
    ];
  };
}

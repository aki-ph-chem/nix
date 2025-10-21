{
  config,
  pkgs,
  nixpkgs-nvim0113,
  ...
}:

let
  nvimConfigPath = "${config.home.homeDirectory}/neovim-config/nvim";
  skkDict = pkgs.libskk;
  skkDictPath = "${skkDict}/share/skk/SKK-JISYO.L";
  traceSkkDictPath = builtins.trace ("DEBUG: skkDictPath " + skkDictPath) skkDictPath;
  pkgsNvim0113 = import nixpkgs-nvim0113 {
    system = builtins.currentSystem;
  };

  nvimVersion = builtins.getEnv "NVIM_VERSION";
  traceNvimVersion = builtins.trace ("DEBUG: NVIM_VERSION is : " + nvimVersion) nvimVersion;
  nvim = if traceNvimVersion == "0.11.3" then pkgsNvim0113.neovim else pkgs.neovim;

  neovimExtraPackages = [
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
  extraPkackgesBinPath = pkgs.lib.makeBinPath neovimExtraPackages;
  nvimWrapper = pkgs.writeShellScriptBin "nvim" ''
    export SKK_JISYO_L_PATH="${traceSkkDictPath}"
    export PATH="${extraPkackgesBinPath}:$PATH"

    exec ${nvim}/bin/nvim "$@"
  '';
in
{

  home.file.".config/nvim" = {
    source = config.lib.file.mkOutOfStoreSymlink "${nvimConfigPath}";
    recursive = true;
  };

  home.packages = [
    pkgs.libskk
    nvimWrapper
  ];

}

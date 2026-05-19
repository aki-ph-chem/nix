{
  config,
  pkgs,
  ...
}:

let
  nvimConfigPath = "${config.home.homeDirectory}/neovim-config/nvim";
  errorMessageNvim = ''
    Neovim config not found at ${nvimConfigPath}. 
    Please clone the repository aki-ph-chem/neovim-config from github.com as below(https):
    git clone https://github.com/aki-ph-chem/neovim-config.git ${config.home.homeDirectory}/neovim-config
  '';
  libSkk = pkgs.libskk;
  # skk dict
  skkDictPath = "${libSkk}/share/skk/SKK-JISYO.L";
  # skk emoji dict ja
  skkEmojiDictJa = pkgs.fetchFromGitHub {
    owner = "ymrl";
    repo = "SKK-JISYO.emoji-ja";
    rev = "5b4df40f8ac71760816f1b2929f493505b463bd1";
    hash = "sha256-awUfIbKeFAB1NqrNPUohPJa+MLYe7TaUKkUW33lKmtc=";
  };
  skkEmojiDictJaPath = "${skkEmojiDictJa}/SKK-JISYO.emoji-ja.utf8";
  # skk emoji dict en
  skkEmojiDict = builtins.fetchTarball {
    url = "https://github.com/uasi/skk-emoji-jisyo/archive/refs/heads/master.tar.gz";
    sha256 = "0pg4cgc5qhal2g38wdrzfhpxxa2iabbrn09chhhkj258w2h2xw6b";
  };
  skkEmojiDictPath = "${skkEmojiDict}/SKK-JISYO.emoji.utf8";
in
{

  home.file.".config/nvim" =
    if builtins.pathExists "${nvimConfigPath}" then
      {
        source = config.lib.file.mkOutOfStoreSymlink "${nvimConfigPath}";
        recursive = true;
      }
    else
      builtins.abort errorMessageNvim;

  home.packages = [
    pkgs.libskk
  ];

  programs.neovim = {
    enable = true;
    viAlias = true;
    sideloadInitLua = true;

    extraWrapperArgs = [
      "--set"
      "SKK_JISYO_L_PATH"
      skkDictPath
      "--set"
      "SKK_JISYO_EMOJI_JA_PATH"
      skkEmojiDictJaPath
      "--set"
      "SKK_JISYO_EMOJI_PATH"
      skkEmojiDictPath
    ];

    extraPackages = [
      # Language Servers
      pkgs.gopls
      ## lua-language-server
      pkgs.lua-language-server
      ## Language server for Nix Language
      pkgs.nil
      ## ty(Language server & type checker for Python)
      pkgs.ty
      ## Language server for Tex(LaTex)
      pkgs.texlab
      ## Language server for Typst
      pkgs.tinymist
      ## Language server for Markdown
      pkgs.markdown-oxide
      ## CMake Language Servers
      pkgs.cmake-language-server
      ## Language Servers for Python
      pkgs.pyright
      ## Language server for TypeScript & JavaScript
      pkgs.typescript-language-server
      ## HTML/CSS/JSON/ESLint language servers extracted from vscode.
      pkgs.vscode-langservers-extracted

      # fromatter
      ## emf-langserver
      pkgs.efm-langserver
      ## fomatter for Lua
      pkgs.stylua
      ## formatter for json
      pkgs.jq
      ## fomatter for Nix Language
      pkgs.nixfmt
      ## fromatter for Python
      pkgs.ruff

      # others
      ## tree-sitter
      pkgs.tree-sitter
      ## for denops
      pkgs.deno
    ];
  };
}

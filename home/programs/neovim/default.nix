{ pkgs, ... }: {
  programs.neovim = {
    enable = true;

    extraLuaConfig = builtins.concatStringsSep "\n" (map builtins.readFile [
      ./settings.lua
      ./lsp-config.lua
      ./telescope.lua
    ]);

    plugins = with pkgs.vimPlugins; [
      catppuccin-nvim
      gruvbox-nvim
      nvim-treesitter.withAllGrammars
      nvim-lspconfig
      nvim-cmp
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      cmp-cmdline
      cmp_luasnip
      nvim-web-devicons
      luasnip
      formatter-nvim
      trouble-nvim
      telescope-nvim
      telescope-fzf-native-nvim
    ];
  };

  home.packages = with pkgs; [
    # some other lsp related packages / dev tools
    typst
    shellcheck
    nodePackages.bash-language-server
    gawk
    # python
    black
    # lua
    stylua
    # rust/c/c++
    rustup
    mold
    lldb
    clang-tools
    gcc
    # nix lsp
    nil
  ];
}

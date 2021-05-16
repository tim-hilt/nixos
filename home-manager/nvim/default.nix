{ pkgs }: {
  enable = true;
  package = pkgs.neovim-nightly;
  viAlias = true;
  vimAlias = true;
  plugins = with pkgs.vimPlugins; [
    nvim-treesitter
    vim-commentary
    vim-surround
    vim-nix
    # Custom-built packages; Commented out until I know how to build them with flakes
    # vimPlugsFromSource.nvim-autopairs
    # vimPlugsFromSource.rainbow-parentheses
  ];
  extraConfig = ''
    ${builtins.readFile ./init.vim}
  '';
}

{ pkgs, ... }:
let vimPlugsFromSource = (import ./nvim) pkgs;
in {
  imports = [ <home-manager/nixos> ];

  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;

  home-manager.users.tim = { pkgs, ... }: {
    home.packages = with pkgs; [
      spotify
      google-chrome
      plasma-pa
      dmenu
      fd
      ripgrep
      hack-font
      hsetroot
      dunst
      udiskie
      playerctl
      alsaUtils
      sxiv
      highlight
      nixfmt
      (import ./hello-derivation.nix pkgs)
    ];
    programs = {
      vscode = import ./vscode.nix pkgs;
      alacritty = import ./alacritty.nix;
      zathura.enable = true;
      fish = {
        enable = true;
        shellAbbrs = {
          # Below is the command that builds the system selectively:
          nrs =
            "doas nixos-rebuild switch -I nixos-config=/home/tim/dev/nixos/profiles/$hostname";
          k = "kill (ps aux | fzf | awk '{print $2}')";
          gpm = "git push -u origin main";
          r = "ranger";
        };
      };
      git = {
        enable = true;
        userName = "Tim Hilt";
      };
      starship = {
        enable = true;
        enableFishIntegration = true;
      };
      fzf = { enable = true; };
      htop = { enable = true; };
      neovim = {
        enable = true;
        package = pkgs.neovim-nightly;
        viAlias = true;
        vimAlias = true;
        plugins = with pkgs.vimPlugins; [
          nvim-treesitter
          vim-commentary
          vim-surround
          vim-nix
          # Custom-built packages
          vimPlugsFromSource.nvim-autopairs
          vimPlugsFromSource.rainbow-parentheses
        ];
        extraConfig = ''
          ${builtins.readFile ./nvim/init.vim}
        '';
      };
    };
  };
}

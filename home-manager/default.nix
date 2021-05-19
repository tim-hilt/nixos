{ pkgs, ... }: {
  imports = [ ./alacritty.nix ./vscode.nix ./nvim ];

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
    # (import ./hello-derivation.nix pkgs)  # Commented out until I know how to properly use this with flakes
  ];

  programs = {
    zathura.enable = true;
    fish = {
      enable = true;
      shellAbbrs = {
        k = "kill (ps aux | fzf | awk '{print $2}')";
        r = "ranger";
        nrs = "sudo nixos-rebuild switch";
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
  };
}

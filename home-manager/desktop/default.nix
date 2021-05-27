{ pkgs, ... }: {
  imports = [ ./alacritty.nix ./vscode.nix ];

  home.packages = with pkgs; [
    alsaUtils
    ark
    dmenu
    dunst
    google-chrome
    hack-font
    hsetroot
    plasma-pa
    playerctl
    spotify
    sxiv
    udiskie
    hello-kde
  ];

  programs.zathura.enable = true;
}

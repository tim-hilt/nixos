{ pkgs, ... }: {
  imports = [ ./alacritty.nix ./vscode.nix ];

  home.packages = with pkgs; [
    spotify
    google-chrome
    plasma-pa
    dmenu
    hack-font
    hsetroot
    dunst
    udiskie
    playerctl
    alsaUtils
    sxiv
    # (import ./hello-derivation.nix pkgs)  # Commented out until I know how to properly use this with flakes
  ];

  programs.zathura.enable = true;
}

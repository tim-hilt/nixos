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
    # (import ./hello-derivation.nix pkgs)  # Commented out until I know how to properly use this with flakes
  ];

  programs.zathura.enable = true;
}

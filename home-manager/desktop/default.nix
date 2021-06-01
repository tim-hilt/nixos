{ pkgs, ... }: {
  # Link ./settings.json like this:
  # ln -s /home/tim/dev/nixos/home-manager/desktop/vscode/settings.json /home/tim/.config/Code/UseR/settings.json

  imports = [ ./alacritty.nix ./vscode ];

  home.packages = with pkgs; [
    alsaUtils
    ark
    dmenu
    google-chrome
    hack-font
    hsetroot
    plasma-pa
    playerctl
    spotify
    sxiv
    udiskie
    hello-kde
    thunderbird
  ];

  programs.zathura.enable = true;

  services.dunst = {
    enable = true;
  };
}

{ pkgs, nix-doom-emacs, ... }: {
  # Link ./settings.json like this:
  # ln -s /home/tim/dev/nixos/home-manager/desktop/vscode/settings.json /home/tim/.config/Code/UseR/settings.json

  imports = [ nix-doom-emacs.hmModule ./alacritty.nix ./vscode ];

  home.packages = with pkgs; [
    alsaUtils
    ark
    google-chrome
    gparted
    hack-font
    plasma-pa
    spotify
    sxiv
    hello-kde
    thunderbird
    fishPlugins.done
  ];

  fonts.fontconfig.enable = true;

  programs.zathura.enable = true;

  programs.doom-emacs = {
    enable = true;
    doomPrivateDir = ./doom.d;
  };
}

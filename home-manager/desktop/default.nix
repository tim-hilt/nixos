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

  programs.fish.plugins = [
    {
      name = "done";
      src = pkgs.fetchFromGitHub {
        owner = "franciscolourenco";
        repo = "done";
        rev = "master";
        sha256 = "sha256-dQ674M0ov6POPwEVB8NM2384StjHufZGszwfgDXXKKE=";
      }
    }
  ];

  services.dunst = {
    enable = true;
  };
}

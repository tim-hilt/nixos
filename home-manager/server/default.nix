{ pkgs, ... }: {
  imports = [ ./nvim ];

  home.packages = with pkgs; [ fd ripgrep highlight nixfmt ];

  programs.fish = {
    enable = true;
    shellAbbrs = {
      k = "kill (ps aux | fzf | awk '{print $2}')";
      r = "ranger";
      nrs = "sudo nixos-rebuild switch";
    };
  };

  programs.git = {
    enable = true;
    userName = "Tim Hilt";
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.fzf = { enable = true; };

  programs.htop = { enable = true; };
}

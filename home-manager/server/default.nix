{ pkgs, ... }: {
  imports = [ ./nvim ];

  home.packages = with pkgs; [ fd ripgrep highlight nixfmt bat ];

  programs.fish = {
    enable = true;
    functions = {
      fish_greeting = {
        body = "";
      };
    };
    shellAbbrs = {
      k = "kill (ps aux | fzf | awk '{print $2}')";
      r = "ranger";
      nrs = "sudo nixos-rebuild switch";
      e = "nvim (fd -t f | fzf --preview='bat --color=always {}')";
    };
    plugins = [
      {
        name = "park.fish";
        src = pkgs.fetchFromGitHub {
          owner = "mattgreen";
          repo = "park.fish";
          rev = "main";
          sha256 = "sha256-dQ674M0ov6POPwEVB8NM2384StjHufZGszwfgDXXKKE=";
        };
      }
    ];
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

  programs.direnv = {
    enable = true;
    enableNixDirenvIntegration = true;
    enableFishIntegration = true;
  };
}

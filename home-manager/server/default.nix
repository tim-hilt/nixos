{ pkgs, ... }: {
  imports = [ ./nvim ];

  home.packages = with pkgs; [ fd ripgrep highlight nixfmt bat any-nix-shell ];

  programs.fish = {
    enable = true;
    functions = { fish_greeting = { body = ""; }; };
    shellAbbrs = {
      kill = "kill (ps aux | fzf | awk '{print $2}')";
      r = "ranger";
      nrs = "sudo nixos-rebuild switch";
      e = "nvim (fd -t f | fzf --preview='bat --color=always {}')";
      ni = "nmcli device wifi list";
      iso_usb =
        "sudo dd bs=4M if=path/to/input.iso of=/dev/sd<?> conv=fdatasync status=progress";
    };
    plugins = [{
      name = "park.fish";
      src = pkgs.fetchFromGitHub {
        owner = "mattgreen";
        repo = "park.fish";
        rev = "main";
        sha256 = "sha256-oJEmSez26xANGUlbTvMSfuv24/VpF18mzFi+NrWg55Q=";
      };
    }];
    promptInit = ''
      any-nix-shell fish --info-right | source
    '';
  };

  programs.git = {
    enable = true;
    userName = "Tim Hilt";
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.htop = { enable = true; };

  programs.direnv = {
    enable = true;
    enableNixDirenvIntegration = true;
    enableFishIntegration = true;
  };
}

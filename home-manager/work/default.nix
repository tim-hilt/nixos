{ pkgs, ... }: {

  home.packages = with pkgs; [
    teams
    jetbrains.idea-ultimate
    keepassxc
  ];

  programs.git = {
    userEmail = "thilt@in-technology.eu";
    extraConfig.core.hooksPath = toString ./git-hooks;
  };
}

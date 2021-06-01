{ pkgs, ... }: {

  home.packages = with pkgs; [
    teams
    jetbrains.idea-ultimate
    keepassxc
    go
    gcc
  ];

  programs.git = {
    userEmail = "thilt@in-technology.eu";
    extraConfig.core.hooksPath = toString ./git-hooks;
  };

  programs.vscode.extensions = with pkgs.vscode-extensions; [ golang.Go ];
}

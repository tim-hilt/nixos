{ pkgs, ... }: {

  home.packages = with pkgs; [
    jetbrains.idea-ultimate
    keepassxc
    gcc
    gnumake
    kubectl
    kind
    yarn
  ];

  programs.git = {
    userEmail = "thilt@in-technology.eu";
    extraConfig.core.hooksPath = toString ./git-hooks;
  };

  programs.vscode.extensions = with pkgs.vscode-extensions; [
    golang.Go
    github.vscode-pull-request-github
  ];

  programs.go = {
    enable = true;
    goPrivate = [ "git.daimler.com/*" ];
  };
}

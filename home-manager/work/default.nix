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

  programs.vscode.extensions = (with pkgs.vscode-extensions; [
    golang.Go
    github.vscode-pull-request-github
  ]) ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
    {
      name = "vscode-thunder-client";
      publisher = "rangav";
      version = "1.4.1";
      sha256 = "sha256-31OGOtjcrBQgbGIDojtnsAnLLa/EsQprBMTTtngzejI=";
    }
  ];

  programs.go = {
    enable = true;
    goPrivate = [ "git.daimler.com/*" ];
  };
}

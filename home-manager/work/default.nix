{ pkgs, ... }: {

  home.packages = with pkgs; [
    jetbrains.idea-ultimate
    docker-compose
    keepassxc
    gcc
    gnumake
    yarn
    kubectl
    kube3d
    kubernetes-helm
    k9s
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

  programs.fish.shellAbbrs = {
    k = "kubectl";
  };
}

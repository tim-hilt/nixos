{ pkgs, ... }: {

  home.packages = with pkgs; [
    jetbrains.idea-ultimate
    docker-compose
    keepassxc
    gcc
    gnumake
    yarn
    kubectl
    kind
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
    ms-azuretools.vscode-docker
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

  programs.fish.shelAbbrs = {
    k = "kubectl";
    dirm = "docker image rm -f (docker images | fzf | awk '{print $3}')";
    dcrm = "docker container rm (docker ps -a | fzf | awk '{print $1}')"
  };
}

{ pkgs, ... }: {
  programs.vscode = {
    enable = true;
    extensions = (with pkgs.vscode-extensions; [
      vscodevim.vim
      file-icons.file-icons
      github.github-vscode-theme
      coenraads.bracket-pair-colorizer-2
      bbenoist.Nix
      brettm12345.nixfmt-vscode
      gruntfuggly.todo-tree
    ]) ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "vscode-fileutils";
        publisher = "sleistner";
        version = "3.4.5";
        sha256 = "0f5n0i337h8bc66zv7j54rl42na09jpcivhs5s5f59g4vavrhfk7";
      }
      {
        name = "auto-comment-blocks";
        publisher = "kevinkyang";
        version = "1.0.1";
        sha256 = "sha256-KwS69LhhmT/6J35JOsxvScUMGkYptAt1VofPem3qwA0=";
      }
    ];
  };
}

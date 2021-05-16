{ pkgs }: {
  enable = true;
  extensions = (with pkgs.vscode-extensions; [
    # TODO: Add Vim-ext along with config
    eamodio.gitlens
    file-icons.file-icons
    github.github-vscode-theme
    coenraads.bracket-pair-colorizer-2
    bbenoist.Nix
    brettm12345.nixfmt-vscode
  ]) ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [{
    name = "vscode-fileutils";
    publisher = "sleistner";
    version = "3.4.5";
    sha256 = "0f5n0i337h8bc66zv7j54rl42na09jpcivhs5s5f59g4vavrhfk7";
  }];
  userSettings = {
    "workbench.colorTheme" = "GitHub Light";
    "workbench.sideBar.location" = "right";
    "workbench.iconTheme" = "file-icons";
    "workbench.startupEditor" = "none";
    "editor.minimap.enabled" = false;
    "window.menuBarVisibility" = "toggle";
    "breadcrumbs.enabled" = false;
    "workbench.settings.editor" = "json";
    "git.confirmSync" = false;
    "editor.selectionClipboard" = false;
    "workbench.editor.enablePreviewFromQuickOpen" = false;
    "workbench.editor.enablePreview" = false;
    "editor.scrollbar.horizontal" = "hidden";
    "editor.scrollbar.vertical" = "hidden";
    "telemetry.enableTelemetry" = false;
    "telemetry.enableCrashReporter" = false;
  };
}

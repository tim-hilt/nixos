{pkgs, ...}:
{
  nvim-autopairs = pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "nvim-autopairs";
    version = "master";
    src = pkgs.fetchFromGitHub {
      owner = "windwp";
      repo = "nvim-autopairs";
      rev = "master";
      sha256 = "sha256:1rar4dkd0i277k71a0ydw3ipgbxjjg1hmhddwd993ihcwvk5d496";
    };
  };
  rainbow-parentheses = pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "rainbow_parentheses.vim";
    version = "master";
    src = pkgs.fetchFromGitHub {
      owner = "junegunn";
      repo = "rainbow_parentheses.vim";
      rev = "master";
      sha256 = "sha256:0izbjq6qbia013vmd84rdwjmwagln948jh9labhly0asnhqyrkb8";
    };
  };
}

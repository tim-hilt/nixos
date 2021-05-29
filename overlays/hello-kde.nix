{ pkgs, ... }:
pkgs.libsForQt5.callPackage ({ mkDerivation }: mkDerivation) { } rec {
  name = "hello-kde";
  version = "Hidden Hedgehog";
  src = pkgs.fetchFromGitHub {
    owner = "n4n0GH";
    repo = "hello";
    rev = "master";
    sha256 = "sha256-dQ674M0ov6POPwEVB8NM2384StjHufZGszwfgDXXKKE=";
  };
  nativeBuildInputs = with pkgs; [ gcc cmake ];
  buildInputs = with pkgs; [
    extra-cmake-modules
    epoxy
    xorg.libXdmcp
    libsForQt5.kconfig
    libsForQt5.kconfigwidgets
    libsForQt5.kcrash
    libsForQt5.kglobalaccel
    libsForQt5.kio
    libsForQt5.kinit
    libsForQt5.kwin
    libsForQt5.knotifications
    libsForQt5.qt5.qtbase
    libsForQt5.qt5.qttools
    libsForQt5.qt5.qtx11extras
  ];
  preConfigure = ''
    local modulepath=$(kf5-config --install module)
    local datapath=$(kf5-config --install data)
    substituteInPlace kwin-effects/CMakeLists.txt \
    --replace "\''${MODULEPATH}" "$out/''${modulepath#/nix/store/*/}" \
    --replace "\''${DATAPATH}"   "$out/''${datapath#/nix/store/*/}"
  '';
}

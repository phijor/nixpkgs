{
  agda2hs-version,
  fetchFromGitHub,
  lib,
  mkDerivation,
}:

let
  version = agda2hs-version;
  pname = "agda2hs";
in
mkDerivation {
  inherit pname version;

  src = fetchFromGitHub {
    repo = pname;
    owner = "agda";
    rev = "v${version}";
    hash = "sha256-19NGyK7qbsQ+EBX6lygNFOXRyDm/48KlBf8ixBU7PUw=";
  };

  preBuild = ''
    echo "{-# OPTIONS --sized-types #-}" > Everything.agda
    echo "module Everything where" >> Everything.agda
    find lib -name '*.agda' | sed -e 's|lib\/||;s|\/|.|g;s|\.agda$||;s|^|import |' >> Everything.agda
  '';

  meta = with lib; {
    description = "Compiling Agda code to readable Haskell";
    homepage = src.meta.homepage;
    license = licenses.mit;
    platforms = platforms.unix;
    maintainers = with maintainers; [ phijor ];
  };
}

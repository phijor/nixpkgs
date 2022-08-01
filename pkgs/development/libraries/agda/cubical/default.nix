{ lib, mkDerivation, fetchFromGitHub, ghc, glibcLocales }:

mkDerivation rec {
  pname = "cubical";
  version = "0.4pre4a1f5fd";

  src = fetchFromGitHub {
    repo = pname;
    owner = "agda";
    rev = "4a1f5fdf788258952842622ca11744d413e3793c";
    sha256 = "sha256-vzu8vKsRHtURyz0XaQQvwgBoi1QXpIgGQDa6gJob2RE=";
  };

  LC_ALL = "en_US.UTF-8";

  preConfigure = ''export AGDA_EXEC=agda'';

  # The cubical library has several `Everything.agda` files, which are
  # compiled through the make file they provide.
  nativeBuildInputs = [ ghc glibcLocales ];
  buildPhase = ''
    make
  '';

  meta = with lib; {
    description =
      "A cubical type theory library for use with the Agda compiler";
    homepage = src.meta.homepage;
    license = licenses.mit;
    platforms = platforms.unix;
    maintainers = with maintainers; [ alexarice ryanorendorff ];
  };
}

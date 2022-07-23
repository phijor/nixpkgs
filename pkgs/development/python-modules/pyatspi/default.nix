{ lib, fetchurl, pkg-config, buildPythonPackage, isPy3k, at-spi2-core, pygobject3, gnome }:

buildPythonPackage rec {
  pname = "pyatspi";
  version = "2.45.1";
  format = "other";

  src = fetchurl {
    url = "mirror://gnome/sources/${pname}/${lib.versions.majorMinor version}/${pname}-${version}.tar.xz";
    sha256 = "u6fCZjQw5VEjpEPzelop5764sBZJvbKWmtPrlB2qwa4=";
  };

  nativeBuildInputs = [ pkg-config ];

  buildInputs = [
    at-spi2-core
    pygobject3
  ];

  disabled = !isPy3k;

  passthru = {
    updateScript = gnome.updateScript {
      packageName = pname;
      attrPath = "python3.pkgs.${pname}";
      versionPolicy = "odd-unstable";
    };
  };

  meta = with lib; {
    description = "Python client bindings for D-Bus AT-SPI";
    homepage = "https://wiki.linuxfoundation.org/accessibility/d-bus";
    license = licenses.gpl2;
    maintainers = with maintainers; [ jtojnar ];
    platforms = with platforms; unix;
  };
}

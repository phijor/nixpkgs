{
  lib,
  fetchFromGitHub,
  stdenvNoCC,
  writeShellApplication,

  # runtime dependencies
  coreutils,
  gawk,
  ghostscript,
}:

let
  version = "1.2";
  shrinkpdf = stdenvNoCC.mkDerivation (self: {
    name = "shrinkpdf";
    inherit version;

    src = fetchFromGitHub {
      name = self.name;
      owner = "aklomp";
      repo = "shrinkpdf";
      rev = "v${version}";
      sha256 = "sha256-LqBjkvs9H2V1kWj4y/Vuc2G/b9iy8ja2i5OhCV2x9nM=";
    };

    dontConfigure = true;
    dontBuild = true;

    installPhase = ''
      runHook preInstall
      install -Dm755 "shrinkpdf.sh" -t "$out/bin"
      runHook postInstall
    '';
  });
in
writeShellApplication {
  name = "shrinkpdf";

  derivationArgs = {
    inherit version;
  };

  runtimeInputs = [
    shrinkpdf
    coreutils
    gawk
    ghostscript
  ];

  text = ''
    exec shrinkpdf.sh "$@"
  '';

  meta = with lib; {
    description = "shrink PDF files with Ghostscript";
    homepage = "https://github.com/aklomp/shrinkpdf";
    license = licenses.bsd3;
    maintainers = with maintainers; [ phijor ];
    platforms = platforms.all;
  };
}

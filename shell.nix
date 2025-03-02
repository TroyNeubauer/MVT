{ pkgs ? import <nixpkgs> {} }:
let
  python = pkgs.python39;
  pyPkgs = pkgs.python39Packages;
  dyLibs = with pkgs; [stdenv.cc.cc libGL glib zlib];
in pkgs.mkShell {
    nativeBuildInputs = with pkgs.buildPackages; [ ruby_3_2 ];
    buildInputs = with pkgs; [
      pyPkgs.virtualenv
    ];

    shellHook = ''
      SOURCE_DATE_EPOCH=$(date +%s)
      VENV=".mvt39env"
      if test ! -d $VENV; then
        echo "creating venv!"
        virtualenv $VENV
      fi
      source ./$VENV/bin/activate

      export PYTHONPATH='pwd'/$VENV/${python.sitePackages}/:PYTHONPATH;
      export LD_LIBRARY_PATH=${pkgs.lib.makeLibraryPath dyLibs};

      pip install -e ."[dev]"
    '';
}

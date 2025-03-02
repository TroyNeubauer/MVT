{ pkgs ? import <nixpkgs> {} }:
with pkgs; mkShell {
  buildInputs = [
    # Defines a python + set of packages.
    (pkgs.python39.withPackages (ps: with ps; with python3Packages; [
      opencv-python-headless
      numpy
      matplotlib
      h5py
      pyproj
      scikit-image
      ffmpeg
      pvlib
    ]))
  ];
}

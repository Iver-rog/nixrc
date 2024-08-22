{ pkgs ? import <nixpkgs> {} }:
  pkgs.mkShell {
    # nativeBuildInputs is usually what you want -- tools you need to run
  packages = [
    pkgs.gcc

    (pkgs.python3.withPackages (python-pkgs: [
      python-pkgs.numpy
      python-pkgs.sympy
    ]))

    pkgs.cargo 
    pkgs.rustc
    pkgs.rustfmt
    pkgs.clippy

  ];
}

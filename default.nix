{ nixpkgs ? import <nixpkgs> { } }:

let pkgs = [ nixpkgs.swift ];

in nixpkgs.stdenv.mkDerivation {
  name = "env";
  buildInputs = pkgs;
}

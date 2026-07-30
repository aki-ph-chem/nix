#!/usr/bin/env bash

set -euo pipefail

if [[ $# -lt 1 ]]; then
  echo "Usage: $0 <nixpkgs-rev>"
  echo "Example: $0 e2587caef70cea85dd97d7daab492899902dbf5d"
  exit 1
fi

REV="$1"

nix eval --raw "github:nixos/nixpkgs/${REV}#linuxPackages.kernel.version"
echo

hostname := "taipei"
nix-config-local := "/home/grim/nix-config"
export NH_FLAKE := "github:GrimOutlook/nix-host-{{hostname}}"

default:
  just --list

us: update home

alias switch := home

home *args="":
  nh home switch . -c {{hostname}} {{args}}

os:
  nh os switch . -H {{hostname}}

update:
  nix flake update

check:
  nix flake check

check-local PATH=nix-config-local:
  nix flake check --no-build --override-input nix-config path:{{PATH}}

switch-local PATH=nix-config-local:
  just home -- --override-input nix-config path:{{PATH}}

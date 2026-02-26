hostname := "taipei"
export NH_FLAKE := "github:GrimOutlook/nix-host-{{hostname}}"

default:
  just --list

us: update home

alias switch := home

home:
  nh home switch . -c {{hostname}}

os:
  nh os switch . -H {{hostname}}

update:
  nix flake update

check:
  nix flake check

check-local PATH="/home/grim/nix-config":
  nix flake check --no-build --override-input nix-config path:{{PATH}}

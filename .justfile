hostname := "taipei"
export NH_FLAKE := "github:GrimOutlook/nix-host-{{hostname}}"

default:
  just --list

alias switch := home

home:
  nh home switch . -c {{hostname}}

os:
  nh os switch . -H {{hostname}}

update:
  nix flake update

check:
  nix flake check

hostname := "taipei"
nix-config-local := "/home/grim/nix-config"
nix-host-justfile-url := \
  "https://raw.githubusercontent.com/GrimOutlook/nix-config/main/just/nix-host.just"

# List recipes
default:
  just --list

import? ".just/nix-host.just"

# Pull latest nix-host justfile from `nix-config` repo
fetch:
  #!/usr/bin/env bash
  set -euo pipefail
  just_host_path=".just/nix-host.just"
  mkdir -p "$(dirname $just_host_path)"
  tmp_path="$(mktemp)"
  if [ -f "$just_host_path" ]; then
    curl {{nix-host-justfile-url}} --output "$tmp_path"
    difft --exit-code "$just_host_path" "$tmp_path" && {
      echo '{{RED}}No changes to justfile found{{NORMAL}}'
      exit 0
    }
  else
    curl {{nix-host-justfile-url}} --output "$tmp_path" || {
      echo "{{RED}}Failed to pull `nix-host.just`{{NORMAL}}"
      exit 1
    }
  fi
  echo "{{GREEN}}Found new justfile to use. Activating...{{NORMAL}}"
  mv "$tmp_path" "$just_host_path"

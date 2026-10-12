#!/usr/bin/env bash
# One-time setup: Aeneas + Charon (via Nix, pinned together) + Lean 4 (via elan)
set -euo pipefail

# 1. Lean toolchain manager
curl -sSf https://raw.githubusercontent.com/leanprover/elan/master/elan-init.sh \
  | sh -s -- -y --default-toolchain none
export PATH="$HOME/.elan/bin:$PATH"
echo 'export PATH="$HOME/.elan/bin:$PATH"' >> ~/.bashrc

# 2. Aeneas sources (needed for the Lean backend library) + matching Charon/Aeneas binaries
[ -d "$HOME/aeneas" ] || git clone --depth 1 https://github.com/AeneasVerif/aeneas "$HOME/aeneas"
nix profile install "$HOME/aeneas#charon" "$HOME/aeneas"

# 3. Lean project depending on the Aeneas Lean library
cd "$(dirname "$0")/../lean"
cp "$HOME/aeneas/backends/lean/lean-toolchain" lean-toolchain
cat > lakefile.toml <<TOML
name = "demo"
defaultTargets = ["Proofs"]

[[require]]
name = "aeneas"
path = "$HOME/aeneas/backends/lean"

[[lean_lib]]
name = "RustDemo"

[[lean_lib]]
name = "Proofs"
TOML
lake update || true
lake exe cache get || true   # prebuilt Mathlib, if the Aeneas library needs it
echo "Setup done. Run: bash scripts/run_demo.sh"

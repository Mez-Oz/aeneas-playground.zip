#!/usr/bin/env bash
# Rust --(Charon)--> LLBC --(Aeneas)--> Lean --(lake)--> checked proofs
set -euo pipefail
export PATH="$HOME/.elan/bin:$PATH"
cd "$(dirname "$0")/.."

echo "== 1. Charon: Rust -> LLBC =="
(cd rust-demo && charon cargo --preset=aeneas)

echo "== 2. Aeneas: LLBC -> Lean =="
aeneas -backend lean -dest lean rust-demo/rust_demo.llbc
echo "--- generated lean/RustDemo.lean ---"; cat lean/RustDemo.lean

echo "== 3. Lean: check proofs =="
(cd lean && lake build)

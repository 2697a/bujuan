#!/usr/bin/env bash
# -*- coding: utf-8 -*-

echo "Checking before publishing…"

echo "  → Updating dependencies"
cargo update && cargo upgrade || exit 1

echo "  → Check & Test"
cargo check && cargo nextest run && cargo test --doc || exit 1
cargo clippy || exit 1

echo "  → Format"
cargo fmt || exit 1


pushd napi || exit 1

echo "  → Upgrading N-API dependencies"
yarn upgrade -L || exit 1

echo "  → Rebuild N-API"
yarn build || exit 1

popd || exit 1


echo "Done!"

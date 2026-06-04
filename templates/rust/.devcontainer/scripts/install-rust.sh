#!/bin/bash
set -e

export CARGO_HOME=/usr/local/cargo
export RUSTUP_HOME=/usr/local/rustup

echo "Descargando Rust..."
RUST_TOOLCHAIN="${RUST_TOOLCHAIN:-stable}"

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --default-toolchain "${RUST_TOOLCHAIN}" --profile default --no-modify-path

echo "Rust instalado correctamente"

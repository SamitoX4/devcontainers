#!/bin/bash
set -e

export CARGO_HOME=/usr/local/cargo
export RUSTUP_HOME=/usr/local/rustup

echo "Descargando Rust..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --default-toolchain stable --profile default --no-modify-path

echo "Rust instalado correctamente"

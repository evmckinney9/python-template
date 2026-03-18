#!/usr/bin/env bash
# remove-rust.sh — Disable Rust/PyO3 extension support.
# Re-comments Rust config in pyproject.toml, Makefile, and release.yml.
# Usage: make remove-rust
set -euo pipefail
cd "$(git rev-parse --show-toplevel)"

echo "Disabling Rust/PyO3 extension support..."

# pyproject.toml: comment out setuptools_rust in build requires
sed -i 's/^requires = \["setuptools", "wheel", "setuptools_rust"\]/requires = ["setuptools", "wheel"]      #, "setuptools_rust"]/' pyproject.toml

# pyproject.toml: comment out the setuptools-rust section (skip already-commented lines)
sed -i '/^\[\[tool\.setuptools-rust/,/^binding/s/^/# /' pyproject.toml

# pyproject.toml: comment out the distutils section
sed -i '/^\[tool\.distutils/,/^py_limited_api/s/^/# /' pyproject.toml

# Makefile: comment out setuptools_rust install
sed -i 's/^\t@\$(PIP) install setuptools_rust/\t#@$(PIP) install setuptools_rust/' Makefile

# release.yml: comment out Rust toolchain step
sed -i 's/^      - uses: dtolnay\/rust-toolchain@stable/      # - uses: dtolnay\/rust-toolchain@stable/' .github/workflows/release.yml

echo "Done! Rust support disabled."

#!/usr/bin/env bash
# setup-rust.sh — Enable Rust/PyO3 extension support.
# Uncomments Rust config in pyproject.toml, Makefile, and release.yml.
# Usage: make setup-rust
set -euo pipefail
cd "$(git rev-parse --show-toplevel)"

echo "Enabling Rust/PyO3 extension support..."

# pyproject.toml: uncomment setuptools_rust in build requires
sed -i 's/^requires = \["setuptools", "wheel"\]      #, "setuptools_rust"\]/requires = ["setuptools", "wheel", "setuptools_rust"]/' pyproject.toml

# pyproject.toml: uncomment the setuptools-rust section
sed -i '/^# \[\[tool\.setuptools-rust/,/^# binding/s/^# //' pyproject.toml

# pyproject.toml: uncomment the distutils section
sed -i '/^# \[tool\.distutils/,/^# py_limited_api/s/^# //' pyproject.toml

# Makefile: uncomment setuptools_rust install
sed -i 's/^\t#@\$(PIP) install setuptools_rust/\t@$(PIP) install setuptools_rust/' Makefile

# release.yml: uncomment Rust toolchain step
sed -i 's/^      # - uses: dtolnay\/rust-toolchain@stable/      - uses: dtolnay\/rust-toolchain@stable/' .github/workflows/release.yml

echo "Done! Rust support enabled."
echo "Run 'make init' to reinstall with Rust support."

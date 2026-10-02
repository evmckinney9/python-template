PYTHON_VERSION = python3.12
VENV           = .venv

UV := $(shell command -v uv 2>/dev/null)
ifdef UV
  INSTALL = uv pip install --python $(VENV)/bin/python
else
  INSTALL = $(VENV)/bin/pip install
endif

.DEFAULT_GOAL := help
.PHONY: help init update-hooks reset-venv rebuild test format lint docs docs-serve docs-draft clean

help:  ## List targets
	@awk 'BEGIN {FS = ":.*##"} /^[a-zA-Z_-]+:.*?##/ {printf "  %-24s %s\n", $$1, $$2}' $(MAKEFILE_LIST)

$(VENV)/bin/python:
	$(PYTHON_VERSION) -m venv $(VENV)

init: $(VENV)/bin/python  ## Create the development environment and install git hooks
	@$(VENV)/bin/pip install --upgrade pip --quiet
	$(INSTALL) -e .[dev] --quiet
	@$(VENV)/bin/pre-commit install --hook-type pre-commit --hook-type commit-msg

update-hooks:  ## Bump hook revisions in .pre-commit-config.yaml
	@$(VENV)/bin/pre-commit autoupdate

reset-venv:  ## Delete the environment
	rm -rf $(VENV)

rebuild:  ## Rebuild the Rust extension
	$(INSTALL) -e . --quiet --no-deps

test: rebuild  ## Run Rust and Python tests
	cargo test --manifest-path crates/Cargo.toml --locked --all-targets
	$(VENV)/bin/pytest tests

format:  ## Format Rust and Python in place
	cargo fmt --manifest-path crates/Cargo.toml
	$(VENV)/bin/pre-commit run --all-files

lint:  ## Check formatting, clippy, and ruff without changing anything
	cargo fmt --manifest-path crates/Cargo.toml --check
	cargo clippy --manifest-path crates/Cargo.toml --all-targets --all-features -- -D warnings
	$(VENV)/bin/ruff check src tests docs
	$(VENV)/bin/ruff format --check src tests docs

docs: rebuild  ## Run the doc examples and build docs/_build/html
	@rm -rf docs/_build/html docs/_build/jupyter_execute
	$(VENV)/bin/sphinx-build -b html -W --keep-going docs docs/_build/html

docs-serve: rebuild  ## Serve docs at http://localhost:8000/ and rebuild on every edit
	$(VENV)/bin/sphinx-autobuild --port 8000 docs docs/_build/html

docs-draft: rebuild  ## Like docs-serve, but examples are shown unexecuted
	DOCS_NOEXEC=1 $(VENV)/bin/sphinx-autobuild --port 8000 docs docs/_build/draft

clean:  ## Remove build artifacts and caches
	rm -rf build dist src/*.egg-info .pytest_cache .ruff_cache crates/target \
	       docs/_build docs/apidocs/stubs src/*/_accelerate*.so src/*/_accelerate*.pyd
	find src tests docs -name __pycache__ -type d -prune -exec rm -rf {} +

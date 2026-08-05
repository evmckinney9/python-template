# ---- config ----------------------------------------------------------------
PYTHON_VERSION = python3.12
VENV           = .venv
PIP            = $(VENV)/bin/pip
PYTEST         = $(VENV)/bin/pytest
PRE_COMMIT     = $(VENV)/bin/pre-commit
# Every input that should retrigger a Rust extension rebuild: crate sources and
# manifests/lockfile. target/ is pruned so we never stat the build cache.
RUST_SRC       = $(shell find crates -name target -prune -o -type f \
                   \( -name '*.rs' -o -name 'Cargo.toml' -o -name 'Cargo.lock' \) -print 2>/dev/null)

# Use uv if it's on PATH (dramatically faster installs/builds).
UV := $(shell command -v uv 2>/dev/null)
ifdef UV
  INSTALL = uv pip install --python $(VENV)/bin/python
else
  INSTALL = $(PIP) install
endif

.DEFAULT_GOAL := help
.PHONY: help init rebuild test format lint docs clean

# ---- help ------------------------------------------------------------------
help:  ## Show this help message
	@awk 'BEGIN {FS = ":.*##"; printf "Targets:\n"} /^[a-zA-Z_-]+:.*?##/ {printf "  %-12s %s\n", $$1, $$2}' $(MAKEFILE_LIST)

# ---- environment setup -----------------------------------------------------
init:  ## Create venv, install deps, set up pre-commit hooks (removes existing .venv/)
	rm -rf $(VENV)
	$(PYTHON_VERSION) -m venv $(VENV)
	@$(PIP) install --upgrade pip
	$(INSTALL) -e .[dev] --quiet
	@$(PRE_COMMIT) install && $(PRE_COMMIT) install --hook-type commit-msg
	@$(PRE_COMMIT) autoupdate
	chmod +x .git/hooks/pre-commit
	@touch $(VENV)/.built

# ---- stamp file (rebuild Rust extension only when crate sources change) ----
$(VENV)/.built: $(RUST_SRC) pyproject.toml
	@$(INSTALL) -e . --quiet --no-deps
	@touch $@

# ---- dev loop --------------------------------------------------------------
rebuild: $(VENV)/.built  ## Rebuild the Rust extension if crate sources changed

test: $(VENV)/.built  ## Run pytest
	$(PYTEST) src/tests

format:  ## Run all pre-commit hooks on all files
	$(PRE_COMMIT) run --all-files

lint:  ## Lint without modifying files
	$(VENV)/bin/ruff check src

# ---- documentation ---------------------------------------------------------
docs: $(VENV)/.built  ## Build the docs site (HTML in docs/_build/html)
	$(VENV)/bin/sphinx-build -b html -W --keep-going docs docs/_build/html

# ---- cleanup ---------------------------------------------------------------
clean:  ## Remove temporary files and build artifacts
	@find ./ -type f -name '*.pyc' -delete 2>/dev/null || true
	@find ./ -type d -name '__pycache__' -exec rm -rf {} + 2>/dev/null || true
	@find ./ -type f \( -name 'Thumbs.db' -o -name '*~' \) -delete 2>/dev/null || true
	@rm -rf .cache .pytest_cache .mypy_cache .ruff_cache .tox/ \
	        build dist *.egg-info htmlcov crates/target \
	        src/__pycache__ src/*.egg-info \
	        docs/_build docs/jupyter_execute docs/apidocs/stubs
	@# built Rust extension + its rebuild stamp
	@rm -f $(VENV)/.built src/*/_accelerate*.so

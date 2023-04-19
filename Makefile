PYTHON_VERSION = python3.9
PIP = .venv/bin/pip
PYTEST = .venv/bin/pytest

init:
	$(PYTHON_VERSION) -m venv .venv
	$(PIP) install --upgrade pip
	$(PIP) install -e .[dev]

install:
	$(PIP) install .

test:
	$(PYTEST) tests/

.PHONY: init install requirements test

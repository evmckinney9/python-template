PYTHON_VERSION = python3.9

init:
	$(PYTHON_VERSION) -m venv .venv
	.venv/bin/pip install --upgrade pip
	.venv/bin/pip install .[dev]

install:
	.venv/bin/pip install .

requirements:
	.venv/bin/pip freeze > requirements.txt

test:
	.venv/bin/pytest src/

.PHONY: init install requirements test

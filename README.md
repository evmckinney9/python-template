# Python Project Template

## My opinionated python boilerplate.

### Git Quick Reference

```bash
make precommit
git add .
git commit
```

If commit command makes changes (e.g. auto-fix formatting), then rerun `git add .` and `git commit` until all tests pass.

## Getting Started

This repository is a template for creating new Python(3.11) projects. To use this template, click the "Use this template" button at the top of the repository page.

The `rename_project.sh` script will automatically rename all instances of the original project name, author name, and other details to match your new repository. The template uses Github Actions to automatically run this script when a new repository is created from the template. Before cloning, wait a moment for the renaming process to complete.

Once cloned, run the following to install the python package and its dependencies in editable mode:

```bash
make init
```

To add a new pip package, modify the `setup.cfg` file and add the package name to the `install_requires` list.

On every commit, the pre-commit hooks will run after `git commit` to ensure that the code is properly formatted and passes all tests. If the hooks exit with failure, either (a) fix the errors and commit again, or (b) the errors were automatically fixed and you need to `git add` the changes and commit again.

To manually run all the pre-commit hooks, run the following:

```bash
make precommit
```

### Available Make Commands

| Command         | Description                                                                                                                                                |
| --------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **`init`**      | Initializes the project by creating a virtual environment, installing the necessary packages, and setting up pre-commit hooks. (Removes existing `.venv/`) |
| `upgrade`       | Upgrades all packages to their latest versions. Use if have added new dependencies to the project.                                                         |
| `clean`         | Removes temporary files and directories created during development.                                                                                        |
| `test`          | Installs the required testing packages and runs the tests in the 'src/tests' directory.                                                                    |
| `format`        | Installs the required formatting packages and runs pre-commit hooks on all files.                                                                          |
| **`precommit`** | Runs the test, installs the required formatting packages, and runs pre-commit hooks on all files.                                                          |

### Configuration Choices

This project uses various tools and configurations to maintain a high standard of code quality and consistency:

- **Ruff**: A high-performance Python linter built in Rust. [Ruff](https://github.com/charliermarsh/ruff) is utilized in this project for its speed and extensive rule set. It consolidates the functionality of various tools like Flake8, isort, pydocstyle, and more, into a single, fast, and efficient package.
- **Black formatter**: The code is automatically formatted using the [Black](https://github.com/psf/black) code formatter, ensuring a consistent code style across the project.
- **isort**: Imports are sorted and organized using [isort](https://github.com/PyCQA/isort), following the Black-compatible profile.
- **pre-commit**: A set of [pre-commit](https://pre-commit.com/) hooks are used to automatically check and enforce code quality standards, such as trailing whitespace removal, JSON formatting, and more.
- **docformatter**: The docstrings are formatted using [docformatter](https://github.com/PyCQA/docformatter) to ensure consistency and readability.
- **pytest**: Tests are written and executed using the [pytest](https://docs.pytest.org/en/latest/) framework.

#### Change Permission of rename_project.sh

```bash
git update-index --chmod=+x .github/scripts/*.sh
```

### References:

> [1] https://github.com/rochacbruno/python-project-template
>
> [2] https://duarteocarmo.com/blog/opinionated-python-boilerplate
>
> [3] https://simonwillison.net/2021/Aug/28/dynamic-github-repository-templates/
>
> [4] https://github.com/Qiskit/qiskit_sphinx_theme
>
> [5] https://github.com/qiskit-community/quantum-prototype-template
>
> [6] https://github.com/nbQA-dev/nbQA

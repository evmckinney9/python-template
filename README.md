# Python Project Template

## My opinionated python boilerplate.  

![Tests](https://github.com/evmckinney9/python-template/actions/workflows/tests.yml/badge.svg?branch=main)
![Format Check](https://github.com/evmckinney9/python-template/actions/workflows/format-check.yml/badge.svg?branch=main)

### Available Make Commands

| Command   | Description                                                                                             |
| --------- | ------------------------------------------------------------------------------------------------------- |
| `init`    | Initializes the project by creating a virtual environment, installing the necessary packages, and setting up pre-commit hooks. |
| `test`    | Installs the required testing packages and runs the tests in the 'src/tests' directory.                |
| `format`  | Installs the required formatting packages and runs pre-commit hooks on all files.                       |
| `precommit` | Runs the test, installs the required formatting packages, and runs pre-commit hooks on all files.      |

### Configuration Choices

This project uses various tools and configurations to maintain a high standard of code quality and consistency:

- **Black formatter**: The code is automatically formatted using the [Black](https://github.com/psf/black) code formatter, ensuring a consistent code style across the project.
- **isort**: Imports are sorted and organized using [isort](https://github.com/PyCQA/isort), following the Black-compatible profile.
- **pre-commit**: A set of [pre-commit](https://pre-commit.com/) hooks are used to automatically check and enforce code quality standards, such as trailing whitespace removal, JSON formatting, and more.
- **pydocstyle**: The project uses [pydocstyle](http://www.pydocstyle.org/) to enforce docstring conventions and ensure consistent documentation throughout the code.
- **pytest**: Tests are written and executed using the [pytest](https://docs.pytest.org/en/latest/) framework.
- **Ruff**: A high-performance Python linter built in Rust. [Ruff](https://github.com/charliermarsh/ruff) is utilized in this project for its speed and extensive rule set. It consolidates the functionality of various tools like Flake8, isort, pydocstyle, and more, into a single, fast, and efficient package.

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

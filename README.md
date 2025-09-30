# My opinionated python boilerplate.

- **`make` commands**: Simplified commands for initializing, upgrading, cleaning, testing, and formatting the project.
- **`PyO3` & `setuptools_rust`**: Added support for integrating Rust code into the Python package.
- **GitHub Actions**: Automated building and releasing of Python wheels as GitHub releases.

### Configuration Choices

- **Ruff**: A high-performance Python linter built in Rust. [Ruff](https://github.com/charliermarsh/ruff) is utilized in this project for its speed and extensive rule set. It consolidates the functionality of various tools like Flake8, isort, pydocstyle, and more, into a single, fast, and efficient package.
- **pre-commit**: A set of [pre-commit](https://pre-commit.com/) hooks are used to automatically check and enforce code quality standards, such as trailing whitespace removal, JSON formatting, and more.
- **pytest**: Tests are written and executed using the [pytest](https://docs.pytest.org/en/latest/) framework.

### Some references:
- [Python Project Template by Rocha Bruno](https://github.com/rochacbruno/python-project-template)
- [Opinionated Python Boilerplate by Duarte O. Carmo](https://duarteocarmo.com/blog/opinionated-python-boilerplate)
- [Dynamic GitHub Repository Templates by Simon Willison](https://simonwillison.net/2021/Aug/28/dynamic-github-repository-templates/)
- [Quantum Prototype Template by Qiskit Community](https://github.com/qiskit-community/quantum-prototype-template)
- [nbQA: A Tool for Running Linters on Jupyter Notebooks](https://github.com/nbQA-dev/nbQA)
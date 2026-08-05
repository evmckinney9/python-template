# My opinionated python boilerplate.

- **`make` commands**: Self-documenting targets (`make help`) for initializing, testing, linting, formatting, and building docs.
- **`PyO3` & `setuptools_rust`**: A Rust extension module built into the wheel, with a stamp-file rebuild (`make rebuild`) that only recompiles when crate sources change. Delete `crates/` and the three Rust sections in `pyproject.toml` if you don't need it.
- **Dev container / artifact image**: One multi-stage `.devcontainer/Dockerfile` serves contributors (toolchain image + `make init`, usable from VS Code, Codespaces, Docker/Podman, or Windows' native `wslc`) and artifact-evaluation reviewers (a frozen code+environment image whose build runs the test suite).
- **GitHub Actions**: CI (lint + test), tag-triggered releases (abi3 wheels + sdist + frozen-dependency list attached to a draft GitHub release with an auto-generated changelog), and dormant-until-enabled deployments: a Sphinx docs site on GitHub Pages (`DEPLOY_DOCS` repository variable), PyPI via trusted publishing (`PYPI_PUBLISH`), a GHCR artifact image (`PUBLISH_IMAGE`), and Zenodo DOI archiving (external webhook). See [CONTRIBUTING](.github/CONTRIBUTING.md) for the full feature reference.
- **Artifact evaluation ready**: `template-ARTIFACT.md` mirrors the cTuning/ACM artifact-appendix structure used by HPCA/ISCA/MICRO/ASPLOS; `CITATION.cff` powers GitHub's cite button and Zenodo metadata.

### Configuration Choices

- **Ruff**: A high-performance Python linter built in Rust. [Ruff](https://github.com/astral-sh/ruff) is utilized in this project for its speed and extensive rule set. It consolidates the functionality of various tools like Flake8, isort, pydocstyle, and more, into a single, fast, and efficient package.
- **pre-commit**: A set of [pre-commit](https://pre-commit.com/) hooks automatically check and enforce code quality standards, including a `commit-msg` hook that rejects non-[conventional](https://www.conventionalcommits.org/) commit messages.
- **pytest**: Tests are written and executed using the [pytest](https://docs.pytest.org/en/latest/) framework.
- **Sphinx**: A `docs/` skeleton (furo theme, autosummary API reference, nbsphinx) that builds warning-free from day one; CI keeps it green even before the Pages deploy is turned on.

### Some references:
- [Python Project Template by Rocha Bruno](https://github.com/rochacbruno/python-project-template)
- [Opinionated Python Boilerplate by Duarte O. Carmo](https://duarteocarmo.com/blog/opinionated-python-boilerplate)
- [Dynamic GitHub Repository Templates by Simon Willison](https://simonwillison.net/2021/Aug/28/dynamic-github-repository-templates/)
- [Quantum Prototype Template by Qiskit Community](https://github.com/qiskit-community/quantum-prototype-template)
- [nbQA: A Tool for Running Linters on Jupyter Notebooks](https://github.com/nbQA-dev/nbQA)

### Git Quick Reference

```bash
make precommit
git add .
git commit
```

If commit command makes changes (e.g. auto-fix formatting), then rerun `git add .` and `git commit` until all tests pass.

## Getting Started

Once cloned, run the following to install the python package and its dependencies in editable mode:

```bash
make init
```

On every commit, the pre-commit hooks will run after `git commit` to ensure that the code is properly formatted and passes all tests. If the hooks exit with failure, either (a) fix the errors and commit again, or (b) the errors were automatically fixed and you need to `git add` the changes and commit again.

To manually run all the pre-commit hooks, run the following:

```bash
make precommit
```

## Commit Messages

This project uses [Conventional Commits](https://www.conventionalcommits.org/). The pre-commit hook will reject messages that don't follow this format:

```
type: short description
```

Common types:

| Type         | When to use                                    |
| ------------ | ---------------------------------------------- |
| **`feat`**   | A new feature                                  |
| **`fix`**    | A bug fix                                      |
| **`docs`**   | Documentation changes                          |
| **`refactor`** | Code change that neither fixes a bug nor adds a feature |
| **`test`**   | Adding or updating tests                       |
| **`chore`**  | Maintenance tasks (deps, CI, etc.)             |
| **`perf`**   | Performance improvements                       |

Examples:
```bash
git commit -m "feat: add support for custom hamiltonians"
git commit -m "fix: correct eigenvalue ordering"
git commit -m "docs: update installation instructions"
```

## Creating a Release

Releases are automated via GitHub Actions. When you push a version tag, the CI will:

1. Build Python wheels (across Linux, macOS, Windows)
2. Generate a changelog from your conventional commits
3. Create a GitHub Release with the wheels attached

To create a release:

```bash
# 1. Update the version in pyproject.toml
# 2. Commit the version bump
git add pyproject.toml
git commit -m "chore: bump version to 0.2.0"

# 3. Tag the commit
git tag v0.2.0

# 4. Push the commit and tag
git push && git push --tags
```

The changelog is auto-generated from your commit messages since the last tag, which is why conventional commits matter — `feat:` commits become "Features", `fix:` commits become "Bug Fixes", etc.

## Rust Extensions (Optional)

To add Rust/PyO3 accelerated functions:

```bash
make setup-rust
```

This uncomments the Rust build config in `pyproject.toml`, `Makefile`, and the release workflow. The `crates/` directory contains starter PyO3 code. To disable:

```bash
make remove-rust
```

## Available Make Commands

| Command           | Description                                                                                                                                                |
| ----------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **`init`**        | Initializes the project by creating a virtual environment, installing the necessary packages, and setting up pre-commit hooks. (Removes existing `.venv/`) |
| `upgrade`         | Upgrades all packages to their latest versions. Use if have added new dependencies to the project.                                                         |
| `clean`           | Removes temporary files and directories created during development.                                                                                        |
| `test`            | Installs the required testing packages and runs the tests in the 'src/tests' directory.                                                                    |
| `format`          | Installs the required formatting packages and runs pre-commit hooks on all files.                                                                          |
| **`precommit`**   | Runs the test, installs the required formatting packages, and runs pre-commit hooks on all files.                                                          |
| `setup-rust`      | Enables Rust/PyO3 extension support.                                                                                                                       |
| `remove-rust`     | Disables Rust/PyO3 extension support.                                                                                                                      |

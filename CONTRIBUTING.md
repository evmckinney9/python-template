
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

### Available Make Commands

| Command         | Description                                                                                                                                                |
| --------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **`init`**      | Initializes the project by creating a virtual environment, installing the necessary packages, and setting up pre-commit hooks. (Removes existing `.venv/`) |
| `upgrade`       | Upgrades all packages to their latest versions. Use if have added new dependencies to the project.                                                         |
| `clean`         | Removes temporary files and directories created during development.                                                                                        |
| `test`          | Installs the required testing packages and runs the tests in the 'src/tests' directory.                                                                    |
| `format`        | Installs the required formatting packages and runs pre-commit hooks on all files.                                                                          |
| **`precommit`** | Runs the test, installs the required formatting packages, and runs pre-commit hooks on all files.                                                          |

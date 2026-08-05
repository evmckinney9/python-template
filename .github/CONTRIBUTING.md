# Contributing

## Setup

```bash
make init
```

Creates `.venv`, installs all dependencies, and sets up pre-commit hooks.

**Requirements:** Python 3.12 and a Rust toolchain (`rustup`).

### Dev container (no host setup)

Alternatively, open the repo in a dev container: `.devcontainer/` defines the toolchain image (Python 3.12 + rustup) and runs `make init` on create. Works with VS Code Dev Containers, GitHub Codespaces (badge in the README), or any dev-container-aware tool, over Docker, Podman, or Windows' native `wslc` runtime (point the extension's "Docker Path" setting at `wslc`).

## Make Commands

Run `make help` for the list of available targets. Notables: `make test` rebuilds the Rust extension only when crate sources changed (a stamp file tracks this), `make docs` builds the Sphinx site locally, `make format` runs all pre-commit hooks.

## Commit Messages

This project uses [Conventional Commits](https://www.conventionalcommits.org/). A `commit-msg` hook rejects commits that don't match the format.

```
<type>[(<scope>)][!]: <description>
```

**Common types:** `feat`, `fix`, `perf`, `refactor`, `docs`, `chore`, `test`.

**Examples:**

```bash
git commit -m "feat: add batch processing API"
git commit -m "fix: correct eigenvalue ordering"
git commit -m "perf!: remove legacy solver"   # breaking change
```

The `!` suffix or a `BREAKING CHANGE:` footer marks a breaking change, which appears in release notes regardless of type. Only `feat`, `fix`, and `perf` appear in the auto-generated changelog.

## Pre-commit Hooks

Hooks run automatically on `git commit` (ruff lint + format, file hygiene, commit-message check). If a hook fails, either fix the errors, or the hook already auto-fixed them: `git add` the changes and commit again. Run them manually with `make format`.

## Continuous Integration

- **`ci.yml`**: every push to main and non-draft PR runs pre-commit on all files, then pytest with the Rust extension built.
- **`docs.yml`**: every push to main builds the Sphinx site with warnings-as-errors, whether or not deployment is enabled, so the docs can't rot.
- **`container.yml`**: changes under `.devcontainer/` build both Dockerfile stages; the `artifact` stage runs the test suite inside the image, so a broken container fails CI.
- **`preflight.yml`**: shared guard that skips all of the above on the template repository itself and on freshly generated repos that haven't bootstrapped yet.

## Creating a Release

1. Bump the version in `pyproject.toml` **and** `crates/Cargo.toml` (the release workflow fails if they disagree with the tag).
2. Commit, then tag and push:

   ```bash
   git tag v0.2.0
   git push && git push --tags
   ```

3. `release.yml` verifies the versions, builds abi3 wheels (Linux, macOS, Windows) and an sdist, records `requirements-frozen.txt` (the exact dependency versions the release was built against), generates a changelog from conventional commits, and creates a **draft** GitHub release with everything attached.
4. Review the draft and publish it. Publishing is the single commitment point: it triggers every distribution channel below that you have enabled, and none that you haven't.

## Distribution Channels (all off by default)

Switches are repository variables (Settings -> Secrets and variables -> Actions -> Variables) or toggles on external services; none live in the repo, so repos generated from the template start with everything off. The capabilities stay exercised by CI regardless (wheels, docs, and the container all build continuously), so an off channel doesn't rot.

| Channel | Workflow | Trigger | Turn on by |
| ------- | -------- | ------- | ---------- |
| PyPI package | `publish.yml` | release published | Configure a [trusted publisher](https://docs.pypi.org/trusted-publishers/) on pypi.org for `publish.yml`, then set `PYPI_PUBLISH` to `true`. |
| Container image (GHCR) | `publish-image.yml` | release published | Set `PUBLISH_IMAGE` to `true`. Pushes the self-verifying `artifact` stage as `ghcr.io/<owner>/<repo>:<tag>` for one-command runs: `docker run -it --rm ghcr.io/<owner>/<repo>:<tag>`. |
| Zenodo DOI archive | none (webhook) | release published | On zenodo.org: Settings -> GitHub -> flip this repo on. Every published release is then archived and DOI-minted automatically (per-version DOIs plus a concept DOI for the latest); metadata is read from `CITATION.cff`. Uncomment the DOI badge in the README with the concept DOI. |
| Docs site (GitHub Pages) | `docs.yml` | push to main | Enable Pages (Settings -> Pages -> Source: GitHub Actions), then set `DEPLOY_DOCS` to `true`. |

## Artifact Evaluation

For paper artifacts (HPCA / ISCA / MICRO / ASPLOS and venues using the cTuning appendix):

- **`ARTIFACT.md`** documents the artifact in the appendix's structure (check-list fields, access, installation, workflow, expected results). Keep it current; the camera-ready `ae.tex` is then a reformat of this file.
- **The `artifact` container stage** is the reviewer-facing product: code, environment, and a passing test suite frozen into one image at build time. Enable the GHCR channel above to give reviewers the one-command path; the Codespaces badge is the zero-install browser alternative.
- **`CITATION.cff`** powers GitHub's "Cite this repository" button and Zenodo's deposit metadata; the Zenodo channel above provides the archival DOI that availability badges require.
- **`requirements-frozen.txt`** on each release records the exact environment for reproducibility claims.

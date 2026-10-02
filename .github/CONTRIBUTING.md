# Contributing

## Setup

Development uses Python 3.12 and the Rust version in
[rust-toolchain.toml](../rust-toolchain.toml), which rustup installs automatically.

```sh
git clone https://github.com/{{github_username}}/{{project_name}}.git
cd {{project_name}}
make init
```

### Dev container

`.devcontainer/` defines a toolchain image (Python 3.12 and rustup) that runs
`make init` on create. It works with VS Code Dev Containers, GitHub Codespaces
(badge in the README), and other dev-container tools, over Docker, Podman, or
the Windows `wslc` runtime (set the extension's "Docker Path" to `wslc`).

## Making changes

Run `make test` and `make lint` before submitting changes. Tests rebuild the
Rust extension. Use `make format` for formatting and `make help` for other commands.

Commit hooks enforce [Conventional Commits](https://www.conventionalcommits.org/).
Only `feat`, `fix`, and `perf` commits appear in the generated changelog.
A `!` after the type, or a `BREAKING CHANGE:` footer, marks a breaking change.

## Documentation

Edit the [user guide](../docs/index.rst) and preview it with `make docs-serve`.
Use `jupyter-execute` blocks for Python examples. `make docs` runs them and
fails on any error or Sphinx warning. `make docs-draft` shows the examples
without running them, for fast edits to prose.

## Continuous integration

| Workflow | Runs on | Checks |
| -------- | ------- | ------ |
| `ci.yml` | push to main, non-draft PR | pre-commit, rustfmt, clippy, cargo test, rustdoc, pytest |
| `docs.yml` | push to main, PR | Sphinx build with every example executed, warnings as errors |
| `container.yml` | changes under `.devcontainer/` | both Dockerfile stages; the `artifact` stage runs the test suite |

`preflight.yml` skips these workflows on the template repository and on new
repositories that have not finished bootstrapping.

## Releases

Push a stable `vX.Y.Z` tag matching the version in `pyproject.toml`.
The [release workflow](workflows/release.yml) builds and tests abi3 wheels
(Linux, macOS, Windows) and an sdist, records `requirements-frozen.txt` (the
exact dependency versions of the build), and creates a draft GitHub release
with a changelog. Review the draft and its distributions before publishing.
Publication triggers each distribution channel that is turned on.

## Distribution channels

All channels are off by default. Switches are repository variables
(Settings > Secrets and variables > Actions > Variables) or settings on external
services. CI builds the wheels, docs, and container on every change, so a
channel that is off still works when it is turned on.

| Channel | Workflow | Trigger | Turn on by |
| ------- | -------- | ------- | ---------- |
| PyPI package | `publish.yml` | release published | Configure a [trusted publisher](https://docs.pypi.org/trusted-publishers/) on pypi.org for `publish.yml`, then set `PYPI_PUBLISH` to `true`. |
| Container image (GHCR) | `publish-image.yml` | release published | Set `PUBLISH_IMAGE` to `true`. Pushes the `artifact` stage as `ghcr.io/<owner>/<repo>:<tag>`, run with `docker run -it --rm ghcr.io/<owner>/<repo>:<tag>`. |
| Zenodo DOI archive | none (webhook) | release published | On zenodo.org, Settings > GitHub, turn this repository on. Zenodo archives each published release with a per-version DOI and a concept DOI, using the metadata in `CITATION.cff`. Uncomment the DOI badge in the README with the concept DOI. |
| Docs site (GitHub Pages) | `docs.yml` | push to main | Enable Pages (Settings > Pages > Source: GitHub Actions), then set `DEPLOY_DOCS` to `true`. |

## Artifact evaluation

For paper artifacts (HPCA, ISCA, MICRO, ASPLOS, and other venues that use the
cTuning appendix):

- `ARTIFACT.md` follows the appendix structure (check-list, access,
  installation, workflow, expected results). The camera-ready `ae.tex` is a
  reformat of this file.
- The `artifact` container stage holds the code, the environment, and a passing
  test suite, frozen at build time. The GHCR channel gives reviewers a
  one-command run. The Codespaces badge gives a browser alternative.
- `CITATION.cff` drives GitHub's "Cite this repository" button and the Zenodo
  deposit metadata. The Zenodo channel provides the archival DOI that
  availability badges require.
- `requirements-frozen.txt` on each release records the exact environment.

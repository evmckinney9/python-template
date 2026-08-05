# Artifact: {{project_name}}

<!-- Repo-side artifact documentation, structured after the cTuning/ACM
     artifact appendix (https://github.com/ctuning/artifact-evaluation) used by
     HPCA / ISCA / MICRO / ASPLOS. Keep it current and the camera-ready ae.tex
     becomes a reformat of this file. Delete this file if the project never
     ships a paper artifact. -->

## Abstract

One paragraph: what the artifact contains and which of the paper's claims it supports.

## Artifact check-list (meta-information)

| Field | Value |
| ----- | ----- |
| Algorithm | |
| Program | |
| Compilation | Rust stable (`rustup`) via setuptools-rust; Python 3.12 |
| Data set | |
| Run-time environment | Linux; container image (see below) or any host with Python 3.12 + Rust |
| Hardware | x86-64; no accelerator required |
| Metrics | |
| Output | |
| Experiments | |
| Disk space required | ~ GB |
| Workflow preparation time | ~ minutes |
| Experiment completion time | ~ hours |
| Publicly available | Yes: <https://github.com/{{github_username}}/{{project_name}}> |
| Code licenses | MIT |
| Archived (DOI) | <!-- Zenodo version DOI of the evaluated release --> |

## Description

### How to access

- Source: <https://github.com/{{github_username}}/{{project_name}}> at tag `vX.Y.Z`
- Archived snapshot: Zenodo DOI above
- Container image: `ghcr.io/{{github_username}}/{{project_name}}:vX.Y.Z` (code + environment + passing tests frozen at build; `requirements-frozen.txt` on the release records exact dependency versions)

### Hardware dependencies

### Software dependencies

Docker (for the container path), or Python 3.12 + `rustup` (for the source path).

## Installation

One command, pick by what you already have:

- **Docker:** `docker run -it --rm ghcr.io/{{github_username}}/{{project_name}}:vX.Y.Z`
- **Browser (GitHub Codespaces):** "Open in GitHub Codespaces" badge in the README
- **From source:** `make init`

## Experiment workflow

<!-- Map each figure/table in the paper to the command that regenerates it,
     with per-command runtime estimates. -->

## Evaluation and expected results

<!-- What the reviewer should see, with tolerances where results are
     stochastic or hardware-dependent. -->

## Experiment customization

## Notes

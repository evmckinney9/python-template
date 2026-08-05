"""Sphinx configuration for the {{project_name}} documentation site."""

import os
from importlib.metadata import version as _pkg_version

project = "{{project_name}}"
author = "{{author_name}}"
copyright = "{{author_name}}"

# Single-source the version from installed package metadata (pyproject.toml),
# so a version bump never has to be repeated here.
release = _pkg_version("{{project_name}}")  # full, e.g. "0.1.0"
version = ".".join(release.split(".")[:2])  # short X.Y
html_title = f"{project} {release}"

# Make the pip-installed pandoc (pypandoc_binary) discoverable by nbsphinx, so
# `pip install .[docs]` is self-contained (no system pandoc needed).
try:
    import pypandoc

    os.environ["PATH"] += os.pathsep + os.path.dirname(pypandoc.get_pandoc_path())
except Exception:  # noqa: BLE001
    pass

extensions = [
    "nbsphinx",  # render pages authored as Jupyter notebooks
    "sphinx.ext.intersphinx",  # cross-reference other projects' API objects
    "sphinx.ext.mathjax",  # render LaTeX math
    "sphinx.ext.autodoc",  # API reference from docstrings
    "sphinx.ext.autosummary",  # generate per-object API stub pages
    "sphinx.ext.napoleon",  # google/numpy-style docstrings
    "sphinx.ext.githubpages",  # emit .nojekyll so GitHub Pages serves _static/
]

# API reference generation.
autosummary_generate = True
autodoc_typehints = "description"
autoclass_content = "both"

html_theme = "furo"
html_theme_options = {
    "source_repository": "https://github.com/{{github_username}}/{{project_name}}",
    "source_branch": "main",
    "source_directory": "docs/",
}
html_static_path = ["_static"]
exclude_patterns = ["_build", "**.ipynb_checkpoints"]

# nbsphinx: trust the outputs already stored in each notebook rather than
# re-executing on every build.
nbsphinx_execute = "auto"

intersphinx_mapping = {
    "python": ("https://docs.python.org/3/", None),
}

"""Sphinx configuration for the {{project_name}} documentation site."""

import html
import inspect
import os
from importlib import import_module
from importlib.metadata import version as _pkg_version
from pathlib import Path
from typing import Any

from docutils import nodes
from docutils.parsers.rst import directives
from jupyter_sphinx.ast import JupyterCell, JupyterCellNode
from sphinx.directives.code import CodeBlock
from sphinx.util.docutils import SphinxDirective

project = "{{project_name}}"

release = _pkg_version("{{project_name}}")
version = ".".join(release.split(".")[:2])
html_title = f"{project} {release}"
html_show_copyright = False
templates_path = ["_templates"]

extensions = [
    "sphinx_copybutton",
    "sphinx.ext.intersphinx",
    "sphinx.ext.linkcode",
    "sphinx.ext.autodoc",
    "sphinx.ext.autosummary",
    "jupyter_sphinx",
    "myst_parser",
    "sphinx.ext.napoleon",
    "sphinx.ext.githubpages",
    "sphinx_sitemap",
]

autosummary_generate = True
# Render defaults as written, not their expanded values.
autodoc_preserve_defaults = True
autodoc_typehints = "description"
autoclass_content = "both"
nitpicky = True

jupyter_execute_kwargs = {"allow_errors": False}

html_theme = "furo"
html_static_path = ["_static"]
html_css_files = ["custom.css"]

html_theme_options = {
    "source_repository": "https://github.com/{{github_username}}/{{project_name}}",
    "source_branch": "main",
    "source_directory": "docs/",
}

html_baseurl = "https://{{github_username}}.github.io/{{project_name}}/"
sitemap_url_scheme = "{link}"
sitemap_excludes = ["genindex.html", "search.html"]
exclude_patterns = ["_build", "**.ipynb_checkpoints"]

intersphinx_mapping = {
    "matplotlib": ("https://matplotlib.org/stable/", None),
    "numpy": ("https://numpy.org/doc/stable/", None),
    "python": ("https://docs.python.org/3/", None),
}


_ROOT = Path(__file__).resolve().parent.parent


def linkcode_resolve(domain: str, info: dict[str, str]) -> str | None:
    """Link API objects to their Python source."""
    # One link per page: the documented class or function, not its members.
    if domain != "py" or "." in info["fullname"]:
        return None
    obj = getattr(import_module(info["module"]), info["fullname"], None)
    try:
        source = Path(inspect.getsourcefile(obj)).resolve().relative_to(_ROOT)
        line = inspect.getsourcelines(obj)[1]
    except (OSError, TypeError, ValueError):
        return None
    url = f"https://github.com/{{github_username}}/{{project_name}}/blob/main/{source}"
    return f"{url}#L{line}"


def _hide_generated_source_links(
    _app: Any,
    pagename: str,
    _templatename: str,
    context: dict[str, Any],
    _doctree: Any,
) -> None:
    """Hide source links that would point to ignored autosummary stubs."""
    if pagename.startswith("apidocs/stubs/"):
        context["theme_source_repository"] = ""
        context["show_source"] = False


def _canonical_landing_url(
    app: Any,
    pagename: str,
    _templatename: str,
    context: dict[str, Any],
    _doctree: Any,
) -> None:
    """Point the landing page's canonical link at the directory URL that inbound links use."""
    if pagename == app.config.root_doc:
        context["pageurl"] = app.config.html_baseurl


class _AccessibleJupyterCell(JupyterCell):
    """Attach an explicit description to a cell's generated figure."""

    option_spec = {**JupyterCell.option_spec, "alt": directives.unchanged_required}

    def run(self) -> list[Any]:
        result = super().run()
        for node in result:
            if isinstance(node, JupyterCellNode) and "alt" in self.options:
                node["image_alt"] = self.options["alt"]
        return result


def _describe_cell_images(_app: Any, doctree: Any, _docname: str) -> None:
    """Apply descriptions after jupyter-sphinx has generated output images."""
    for cell in doctree.findall(JupyterCellNode):
        if "image_alt" in cell:
            for output in cell.findall(nodes.image):
                output["alt"] = cell["image_alt"]


class _Unexecuted(CodeBlock):
    """``jupyter-execute`` as a plain code block, for prose drafts (``make docs-draft``)."""

    required_arguments = 0
    option_spec = {
        **CodeBlock.option_spec,
        "hide-code": directives.flag,
        "hide-output": directives.flag,
        "alt": directives.unchanged_required,
    }

    def run(self) -> list[Any]:
        if "hide-code" in self.options:
            return []
        self.arguments = ["python"]
        return super().run()


class _Details(SphinxDirective):
    """Collapse the nested content under a summary line, such as a figure's plotting code."""

    required_arguments = 1
    final_argument_whitespace = True
    has_content = True

    def run(self) -> list[nodes.Node]:
        body = nodes.container()
        self.state.nested_parse(self.content, self.content_offset, body)
        summary = html.escape(self.arguments[0])
        return [
            nodes.raw("", f"<details><summary>{summary}</summary>", format="html"),
            *body.children,
            nodes.raw("", "</details>", format="html"),
        ]


def setup(app: Any) -> None:
    """Register documentation-site callbacks."""
    app.add_directive("details", _Details)
    app.add_directive("jupyter-execute", _AccessibleJupyterCell, override=True)
    app.connect("doctree-resolved", _describe_cell_images)
    app.connect("html-page-context", _hide_generated_source_links)
    app.connect("html-page-context", _canonical_landing_url)
    if os.environ.get("DOCS_NOEXEC"):
        app.add_directive("jupyter-execute", _Unexecuted, override=True)

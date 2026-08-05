# Two products from one file (see CONTRIBUTING "Dev container" and "Artifact
# evaluation"):
#   dev      -- toolchain only; devcontainer.json targets this, then runs
#               `make init` against the live checkout at create time.
#   artifact -- frozen snapshot for artifact evaluation: code + environment +
#               passing tests baked in; published to GHCR by publish-image.yml.

# ---- dev: the toolchain a contributor needs --------------------------------
FROM mcr.microsoft.com/devcontainers/python:3.12 AS dev
USER vscode
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y --profile minimal
ENV PATH="/home/vscode/.cargo/bin:${PATH}"

# ---- artifact: frozen, self-verifying snapshot -----------------------------
FROM dev AS artifact
COPY --chown=vscode:vscode . /artifact
WORKDIR /artifact
RUN python -m venv /home/vscode/venv
ENV PATH="/home/vscode/venv/bin:${PATH}"
# Failing tests fail the image build: a broken artifact cannot be published.
RUN pip install ".[test]" --quiet && pytest src/tests
CMD ["bash"]

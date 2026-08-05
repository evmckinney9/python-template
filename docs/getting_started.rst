Getting started
===============

Install
-------

From source (requires a Rust toolchain, ``rustup``):

.. code-block:: bash

   pip install git+https://github.com/{{github_username}}/{{project_name}}

Or install a pre-built wheel from the
`releases page <https://github.com/{{github_username}}/{{project_name}}/releases>`_
(no build dependencies needed).

Verify
------

.. code-block:: python

   from {{project_name}}.main import Electron

   Electron().charge

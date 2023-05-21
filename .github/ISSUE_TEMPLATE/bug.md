name: 🐛 Bug Report
description: If something isn't working as expected 🤔
title: ''
labels: ['bug']
assignees: 'evmckinney9'

body:

- type: markdown
  attributes:
  value: Thank you for reporting! Please use the search to see if there are any other relevant issues or pull requests.

- type: textarea
  attributes:
  label: Current Behavior
  description: A clear and concise description of the behavior.
  validations:
  required: true
- type: textarea
  attributes:
  label: Input Code
  description: Please provide the code causing the issue. If you have a REPL or Repo link, include it here. Enclose your code in triple backticks (` ``` [multiline code goes here] ``` `) so that it displays correctly.
  value: |
  `js
  var your => (code) => here;
  `
  validations:
  required: true

- type: textarea
  attributes:
  label: Expected behavior/code
  description: A clear and concise description of what you expected to happen (or code).
  validations:
  required: true

- type: textarea
  attributes:
  label: Environment
  description: Please provide details about your operating system. (_e.g._ OS: OSX 10.13.4, Windows 10)
  validations:
  required: true

- type: textarea
  attributes:
  label: Possible Solution
  description: Not required, but if you have suggestions for how a contributor should fix this, or any problems we should be aware of, let us know.
  validations:
  required: false

- type: textarea
  attributes:
  label: Additional context/Screenshots
  description: Add any other context about the problem here. If applicable, add screenshots to help explain.
  validations:
  required: false

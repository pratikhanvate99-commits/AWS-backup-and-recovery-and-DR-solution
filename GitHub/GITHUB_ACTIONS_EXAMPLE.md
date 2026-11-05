# GitHub Actions Example

The repository ships with an **optional** workflow at [`.github/workflows/quality-checks.yml`](../.github/workflows/quality-checks.yml). It checks documentation quality only.

## What it does

| Job | Check | Tooling |
|-----|-------|---------|
| `markdown-lint` | Markdown style and structure | markdownlint-cli2 (config: [`.markdownlint-cli2.jsonc`](../.markdownlint-cli2.jsonc)) |
| `mermaid-validate` | `.mmd` files and Mermaid blocks in Markdown render without syntax errors | Mermaid CLI (`mmdc`) |
| `shell-checks` | `bash -n` syntax check and ShellCheck lint of `Scripts/*.sh` (scripts are **not executed**) | Bash, ShellCheck |
| `secret-scan` | Detects accidentally committed secrets in files and history | Gitleaks |

## What it deliberately does NOT do

- It has **no AWS credentials** and never calls AWS APIs.
- It does **not** deploy, modify or delete infrastructure.
- It uses read-only repository permissions (`contents: read`).

## Enabling

The workflow runs automatically once the repository is pushed to GitHub. Check results under the **Actions** tab. To run it manually, choose **Actions > Repository Quality Checks > Run workflow**.

## Notes

- `gitleaks-action` is free for personal accounts; organisation repositories may require a licence key (`GITLEAKS_LICENSE`). If that applies, replace it with `gitleaks detect` installed from the official release.
- Action versions are pinned to major tags. Review and update them periodically.
- Some GitHub-rendered Mermaid features may differ slightly from the CLI version; if a diagram renders on GitHub but fails in CI, adjust the syntax or relax the job.

## Workflow source

```yaml
name: Repository Quality Checks

# Documentation-quality checks only.
# This workflow does NOT authenticate to AWS and does NOT deploy, modify or delete any infrastructure.

on:
  push:
    branches: [ main ]
  pull_request:
  workflow_dispatch:

permissions:
  contents: read

jobs:
  markdown-lint:
    name: Validate Markdown
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: DavidAnson/markdownlint-cli2-action@v16
        with:
          globs: "**/*.md"

  mermaid-validate:
    name: Validate Mermaid diagrams
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: "20"
      - name: Install Mermaid CLI
        run: npm install --no-save @mermaid-js/mermaid-cli
      - name: Create headless-browser config
        run: echo '{"args":["--no-sandbox","--disable-setuid-sandbox"]}' > "$RUNNER_TEMP/puppeteer.json"
      - name: Render .mmd files (fails on syntax errors)
        run: |
          set -euo pipefail
          for f in Architecture/*.mmd; do
            echo "Validating $f"
            npx mmdc -p "$RUNNER_TEMP/puppeteer.json" -i "$f" -o "$RUNNER_TEMP/$(basename "$f").svg"
          done
      - name: Render Mermaid blocks inside Markdown files
        run: |
          set -euo pipefail
          for f in README.md Architecture/*.md Documentation/*.md; do
            if grep -q '```mermaid' "$f"; then
              echo "Validating Mermaid blocks in $f"
              npx mmdc -p "$RUNNER_TEMP/puppeteer.json" -i "$f" -o "$RUNNER_TEMP/$(basename "$f")"
            fi
          done

  shell-checks:
    name: Shell script syntax and lint
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Bash syntax check (no execution)
        run: |
          set -euo pipefail
          for f in Scripts/*.sh; do
            echo "bash -n $f"
            bash -n "$f"
          done
      - name: ShellCheck
        run: shellcheck Scripts/*.sh

  secret-scan:
    name: Scan for exposed secrets
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
        with:
          fetch-depth: 0
      - uses: gitleaks/gitleaks-action@v2
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

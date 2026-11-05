# Contributing

Thank you for your interest in this project. This repository documents a **manually configured** (AWS Management Console) disaster recovery and backup solution and provides reusable templates and example scripts.

## Ground rules

1. **Never commit secrets.** No access keys, `.pem` files, `.env` files, account IDs, ARNs containing account IDs, or unredacted screenshots. See [`Documentation/08-security-best-practices.md`](Documentation/08-security-best-practices.md).
2. **Keep claims truthful.** Do not describe a feature as implemented unless it was actually configured. Mark ideas as *Proposed*.
3. **No fabricated results.** Do not add invented RTO/RPO values, backup success rates, or screenshots.
4. **Scripts must be safe.** Example scripts must default to read-only or dry-run behaviour and must not contain destructive commands.

## How to contribute

1. Fork the repository and create a branch: `git checkout -b docs/improve-recovery-steps`
2. Make your change and run the local checks:
   ```bash
   # Shell syntax
   for f in Scripts/*.sh; do bash -n "$f"; done
   # Optional linters
   shellcheck Scripts/*.sh
   npx markdownlint-cli2 "**/*.md"
   ```
3. Commit using clear messages (e.g. `docs: clarify EBS restore steps`).
4. Open a pull request describing *what* changed and *why*.

## Style

- Professional technical English, short paragraphs, descriptive headings.
- Use placeholders in the form `<PLACEHOLDER_NAME>`.
- Mermaid diagrams must render on GitHub.

## Reporting security issues

If you find exposed sensitive data in this repository, please open a private report or contact the maintainer directly rather than a public issue.

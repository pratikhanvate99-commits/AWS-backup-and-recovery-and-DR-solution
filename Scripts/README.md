# Scripts

> **EXAMPLES ONLY.** These scripts are illustrative templates. They were **not** used to build, operate or recover the original project (which was configured manually in the AWS Management Console). Review and test them in a non-production account before any real use.

## Safety design

- No credentials, account IDs or secrets are stored; the AWS CLI uses your own profile/role.
- **No destructive commands** (no delete, terminate, deregister or overwrite).
- `backup-example.sh` defaults to **dry-run**; it creates a backup job only if `DRY_RUN=false`.
- `restore-example.sh` only **prints a restore plan** and reads metadata; it never starts a restore.
- `health-check-example.sh` and `verify-backup-example.sh` are **read-only**.

## Scripts

| Script | Purpose | Changes AWS? |
|--------|---------|--------------|
| [`backup-example.sh`](backup-example.sh) | Start an on-demand AWS Backup job | Only when `DRY_RUN=false` (creates a recovery point) |
| [`restore-example.sh`](restore-example.sh) | Show restore metadata and a manual restore plan | No |
| [`health-check-example.sh`](health-check-example.sh) | Report EC2 state, status checks, alarms in ALARM | No |
| [`verify-backup-example.sh`](verify-backup-example.sh) | Check that recent recovery points exist and jobs completed | No |

## Prerequisites

- AWS CLI v2 and Bash 4+.
- Authenticated session (for example, `aws sso login --profile <YOUR_PROFILE>`).
- Variables listed in [`../Configuration/environment-template.md`](../Configuration/environment-template.md).
- Least-privilege permissions (a read-only policy example is in [`../Documentation/08-security-best-practices.md`](../Documentation/08-security-best-practices.md)).

## Usage

```bash
chmod +x *.sh
export AWS_PROFILE="<YOUR_PROFILE>" AWS_REGION="<REGION>"
export BACKUP_VAULT_NAME="<VAULT_NAME>" INSTANCE_ID="<INSTANCE_ID>"

./health-check-example.sh
./verify-backup-example.sh
DRY_RUN=true ./backup-example.sh
```

## Quality checks

```bash
for f in *.sh; do bash -n "$f"; done   # syntax
shellcheck *.sh                        # optional lint
```

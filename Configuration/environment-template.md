# Environment Template

Defines the **variable names** used by the example scripts. This file contains **no real values**. Never commit a populated `.env` file; `.gitignore` already excludes `.env*`.

## Variables

| Variable | Description | Example format (not real) |
|----------|-------------|---------------------------|
| `AWS_PROFILE` | Named AWS CLI profile (preferably SSO or role-based) | `my-dr-profile` |
| `AWS_REGION` | Region to operate in | `<REGION>` |
| `BACKUP_VAULT_NAME` | AWS Backup vault name | `<VAULT_NAME>` |
| `RESOURCE_TAG_KEY` / `RESOURCE_TAG_VALUE` | Tag used to find project resources | `Project` / `<PROJECT_TAG>` |
| `INSTANCE_ID` | EC2 instance to inspect | `i-xxxxxxxxxxxxxxxxx` |
| `RESOURCE_ARN` | ARN of the resource to back up | `<RESOURCE_ARN>` |
| `BACKUP_ROLE_ARN` | Role used by AWS Backup | `<BACKUP_ROLE_ARN>` |
| `RECOVERY_POINT_ARN` | Recovery point to restore (dry-run plan only) | `<RECOVERY_POINT_ARN>` |
| `MAX_BACKUP_AGE_HOURS` | Freshness threshold for verification | `<HOURS>` |
| `DRY_RUN` | `true` (default) prints actions only | `true` |

## Usage

Export variables in your shell session (do not store secrets in files):

```bash
export AWS_PROFILE="<YOUR_PROFILE>"
export AWS_REGION="<REGION>"
export BACKUP_VAULT_NAME="<VAULT_NAME>"
export DRY_RUN="true"
```

## Authentication guidance

- Use `aws configure sso` or an assumed IAM role.
- Do **not** place `AWS_ACCESS_KEY_ID` or `AWS_SECRET_ACCESS_KEY` in any file in this repository.

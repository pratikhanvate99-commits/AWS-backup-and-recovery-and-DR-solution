# Screenshots

This folder is for **real, redacted screenshots** of your own AWS Management Console work. No screenshots are included by default, and none should be fabricated or taken from other people's projects.

## Folders

| Folder | What to add |
|--------|-------------|
| [`EC2/`](EC2/README.md) | Instance list/details, security group, instance status checks |
| [`S3/`](S3/README.md) | Bucket properties: versioning, encryption, lifecycle rules, public-access block |
| [`EBS/`](EBS/README.md) | Volumes and snapshots |
| [`Backup/`](Backup/README.md) | AWS Backup plan, vault, jobs and recovery points |
| [`CloudWatch/`](CloudWatch/README.md) | Alarms, dashboards, SNS topic and subscription |
| [`Recovery/`](Recovery/README.md) | Restore operations and validation results |

## Naming convention

`NN-short-description.png` - for example `01-backup-plan-rules.png`, `02-vault-recovery-points.png`.

## Redaction checklist (mandatory)

Before saving a screenshot, hide or blur:

- [ ] AWS account ID and account alias
- [ ] Email addresses and user names
- [ ] Public and private IP addresses you do not want to expose
- [ ] ARNs containing account IDs
- [ ] Billing and payment information
- [ ] Access keys, secrets, session tokens
- [ ] Anything in the browser tab bar or console header that identifies you

## Adding a screenshot to documentation

```markdown
![AWS Backup plan rules](Screenshots/Backup/01-backup-plan-rules.png)
```

Only reference an image after the file exists, so links do not break.

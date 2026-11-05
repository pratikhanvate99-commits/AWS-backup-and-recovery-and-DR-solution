# 08 - Security Best Practices

## 1. Identity and access (IAM)

- Enable **MFA** on the root user and all human users; do not use root for daily work.
- Grant **least privilege**; start with no permissions and add what is required.
- Prefer **IAM roles** (instance profiles, AWS Backup service role) over long-lived access keys.
- Rotate or remove unused access keys; review access with IAM Access Analyzer / credential report.
- Separate duties: users who run workloads should not be able to delete backups.

### Illustrative read-only monitoring policy (sanitised example)

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "ReadOnlyBackupVisibility",
      "Effect": "Allow",
      "Action": [
        "backup:ListBackupJobs",
        "backup:ListRecoveryPointsByBackupVault",
        "backup:DescribeBackupVault",
        "ec2:DescribeInstances",
        "ec2:DescribeVolumes",
        "ec2:DescribeSnapshots",
        "cloudwatch:DescribeAlarms"
      ],
      "Resource": "*"
    }
  ]
}
```

This is an example for the example scripts, not a policy used in the original project.

## 2. Data protection

- **Encrypt** EBS volumes, snapshots, S3 buckets and backup vaults (AWS-managed or customer-managed KMS keys).
- Enforce **TLS** (`aws:SecureTransport`) on S3 bucket policies.
- Enable S3 **Block Public Access** and **Versioning**.
- Consider **AWS Backup Vault Lock** and S3 Object Lock for immutability (*proposed unless implemented*).
- Keep backups in a separate account/region where feasible.

## 3. Network

- Restrict security groups to required ports and sources; avoid `0.0.0.0/0` for SSH/RDP.
- Use private subnets and VPC endpoints for S3 where the architecture permits.

## 4. Logging and monitoring

- Enable **AWS CloudTrail** for API auditing.
- Use CloudWatch alarms and SNS for failed backup jobs and instance health.
- Review logs after any incident.

## 5. Repository security (before publishing)

### Pre-publish security checklist

Run through every item before `git push`:

- [ ] No `.env`, `*.pem`, `*.key`, `*.ppk`, `credentials`, `rootkey.csv` or `accessKeys.csv` files.
- [ ] No AWS access key IDs (strings beginning `AKIA` / `ASIA`) or secret keys anywhere.
- [ ] No 12-digit AWS account IDs, and no ARNs that contain them.
- [ ] No public/private IP addresses, instance IDs, volume IDs or snapshot IDs that you do not want public.
- [ ] No personal data: email addresses, phone numbers, home addresses.
- [ ] **Screenshots reviewed and redacted** (account ID, email, IPs, ARNs, billing data, console header).
- [ ] No database dumps, backup archives, or `.tfstate` files.
- [ ] `.gitignore` is present and `git status` shows only intended files.
- [ ] Placeholders (`<LIKE_THIS>`) filled only with non-sensitive values.

### Useful verification commands

```bash
# List every file Git would publish
git ls-files

# Search for likely AWS keys and secrets
grep -RInE "AKIA[0-9A-Z]{16}|ASIA[0-9A-Z]{16}|aws_secret_access_key|BEGIN (RSA|OPENSSH|EC) PRIVATE KEY" . --exclude-dir=.git

# Search for 12-digit numbers that could be account IDs
grep -RInE "\b[0-9]{12}\b" . --exclude-dir=.git

# Optional dedicated scanners
gitleaks detect --source . --no-banner
```

### If a secret is committed

1. **Revoke/rotate it immediately** in AWS - assume it is compromised.
2. Remove it from history (`git filter-repo` or BFG Repo-Cleaner) and force-push.
3. Check CloudTrail for unauthorised use.

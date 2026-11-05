# 04 - Infrastructure Setup (Manual, AWS Management Console)

This document records **how the environment is configured conceptually** in the AWS Management Console. Replace every `<PLACEHOLDER>` with your real values and delete steps that do not apply. Do not paste account IDs, ARNs with account IDs, or keys.

> No Infrastructure as Code was used. All steps below are manual.

## 1. Prerequisites

- An AWS account with MFA enabled on the root user (root is not used for daily tasks).
- An IAM user or role with permissions to manage the services below.
- Chosen primary region: `<PRIMARY_REGION>`. Recovery region (if any): `<RECOVERY_REGION>`.

## 2. Network (Amazon VPC)

1. Open **VPC > Your VPCs** and create or choose `<VPC_NAME>` (CIDR `<VPC_CIDR>`).
2. Create subnet(s) `<SUBNET_NAME>` in `<AZ>`.
3. Attach an internet gateway only if the workload needs inbound internet access.
4. Create a security group `<SG_NAME>` allowing only required ports from required sources (for example, SSH only from `<ADMIN_IP>/32`).

## 3. Compute (Amazon EC2)

1. **EC2 > Launch instance**; name `<INSTANCE_NAME>`.
2. AMI `<AMI_DESCRIPTION>`, type `<INSTANCE_TYPE>`.
3. Select the key pair `<KEY_PAIR_NAME>` (store the private key outside the repository).
4. Network settings: `<VPC_NAME>`, `<SUBNET_NAME>`, `<SG_NAME>`.
5. Storage: root volume `<SIZE_GB>` GiB `<VOLUME_TYPE>`, **encryption enabled**.
6. Attach an IAM instance profile if the instance needs AWS API access.
7. Add tags (see [`../Configuration/resource-inventory-template.csv`](../Configuration/resource-inventory-template.csv)).

## 4. Storage (Amazon S3)

1. **S3 > Create bucket**; name `<BUCKET_NAME>` in `<PRIMARY_REGION>`.
2. Keep **Block all public access** enabled.
3. Enable **Bucket Versioning**.
4. Enable default encryption (SSE-S3 or SSE-KMS `<KMS_KEY_ALIAS>`).
5. Add a lifecycle rule (see [`10-cost-optimization.md`](10-cost-optimization.md)).

## 5. Backup (AWS Backup and/or EBS snapshots)

1. **AWS Backup > Backup vaults**: create `<VAULT_NAME>` with encryption key `<KMS_KEY_ALIAS>`.
2. **Backup plans**: create `<PLAN_NAME>` with rule(s) defined in [`05-backup-strategy.md`](05-backup-strategy.md).
3. **Resource assignment**: assign resources by tag (`<TAG_KEY>=<TAG_VALUE>`) or by ID.
4. Use the default AWS Backup service role or a dedicated role `<BACKUP_ROLE_NAME>`.

## 6. Monitoring (CloudWatch and SNS)

1. **SNS > Topics**: create `<SNS_TOPIC_NAME>`; subscribe `<ALERT_EMAIL>` and confirm the subscription.
2. **CloudWatch > Alarms**: create alarms such as EC2 `StatusCheckFailed` and an alarm or event rule for failed backup jobs.
3. Point alarm actions at the SNS topic.
4. Optionally create a dashboard `<DASHBOARD_NAME>`.

## 7. Identity (IAM)

See [`08-security-best-practices.md`](08-security-best-practices.md). Document policies in sanitised form only.

## 8. Evidence

Add redacted screenshots under [`../Screenshots/`](../Screenshots/README.md) to prove each step you actually completed.

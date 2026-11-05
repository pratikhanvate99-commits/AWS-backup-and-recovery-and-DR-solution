# 10 - Cost Optimization

> No cost figures are stated. AWS pricing varies by region and changes over time; use the [AWS Pricing Calculator](https://calculator.aws/) and your own billing data.

## 1. Where costs come from

| Component | Cost driver |
|-----------|-------------|
| EBS snapshots / AWS Backup | Amount of stored data (snapshots are incremental) and retention length |
| S3 | Storage class, volume, requests, data transfer, replication |
| Cross-region copies | Storage in the second region plus transfer charges |
| EC2 (restore tests) | Instance hours while test resources run |
| CloudWatch / SNS | Alarms, custom metrics, log ingestion and storage |
| Data transfer | Inter-region and internet egress |

## 2. Optimisation practices

1. **Right-size retention.** Keep recovery points only as long as required by recovery needs and compliance.
2. **Use S3 lifecycle rules** to transition older backup data to cheaper storage classes (for example, Standard-IA or Glacier tiers) and to expire it.
3. **Expire noncurrent versions** in versioned buckets after `<DAYS>` days, and abort incomplete multipart uploads.
4. **Tag everything** (`Project`, `Owner`, `Environment`) so costs can be filtered in Cost Explorer.
5. **Clean up** orphaned snapshots, unused volumes and test restores after validation.
6. **Match frequency to need.** More frequent backups lower RPO but increase stored data; choose deliberately.
7. **Use AWS Budgets** with an SNS/email alert at `<BUDGET_THRESHOLD>`.
8. **Review regularly** with Cost Explorer and Trusted Advisor (where available).

## 3. Example S3 lifecycle rule (illustrative)

```json
{
  "Rules": [
    {
      "ID": "ExampleBackupLifecycle",
      "Status": "Enabled",
      "Filter": { "Prefix": "backups/" },
      "Transitions": [ { "Days": 30, "StorageClass": "STANDARD_IA" } ],
      "NoncurrentVersionExpiration": { "NoncurrentDays": 90 },
      "AbortIncompleteMultipartUpload": { "DaysAfterInitiation": 7 }
    }
  ]
}
```

Adjust the numbers to your policy; the values above are examples only and not taken from the original project.

## 4. Cost versus protection trade-off

Lower RTO/RPO usually means higher cost (more frequent copies, standby infrastructure). Document your chosen balance in [`../Configuration/recovery-configuration-template.md`](../Configuration/recovery-configuration-template.md).

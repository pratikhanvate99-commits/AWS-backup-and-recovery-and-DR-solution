# 03 - AWS Services

Not every service listed here is necessarily part of the final implementation. Mark each service honestly in the status column.

| Service | Purpose in this project | Key configuration considerations | Status |
|---------|-------------------------|----------------------------------|--------|
| **Amazon EC2** | Runs the primary workload | Instance type, AMI, key pair, IAM instance profile, termination protection | `<CONFIRM>` |
| **Amazon EBS** | Persistent block storage; snapshot source | Volume type, encryption, snapshot schedule | `<CONFIRM>` |
| **Amazon S3** | Object storage for data and backup artefacts | Versioning, default encryption, Block Public Access, lifecycle rules | `<CONFIRM>` |
| **AWS Backup** | Central, policy-based backups with vaults and retention | Backup plan, rules, vault, service role, vault lock (optional) | `<CONFIRM>` |
| **AWS IAM** | Authentication and authorisation | Least privilege, MFA, roles instead of long-lived keys | `<CONFIRM>` |
| **Amazon VPC** | Network isolation | Subnets, route tables, security groups, NACLs | `<CONFIRM>` |
| **Amazon CloudWatch** | Metrics, logs, alarms, dashboards | Alarms on status checks and backup-job failures | `<CONFIRM>` |
| **Amazon SNS** | Alert delivery | Topic, confirmed subscriptions, topic policy | `<CONFIRM>` |
| **AWS Lambda** | Optional automation (for example, tagging or reports) | Execution role, timeout, logging | `Proposed` |

## Service notes

### Amazon EC2 and EBS
EBS snapshots are **incremental** point-in-time copies stored durably by AWS (backed by S3 internally). An AMI can be created from an instance to capture its configuration plus snapshots of attached volumes.

### Amazon S3
S3 provides high durability for objects. Enabling **versioning** protects against overwrite and accidental deletion; **lifecycle rules** move or expire data to control cost.

### AWS Backup
AWS Backup centralises scheduling, retention, encryption and monitoring across supported services. Recovery points are stored in **backup vaults**.

### Amazon CloudWatch and SNS
CloudWatch alarms can publish to an SNS topic, which delivers email or other notifications. AWS Backup job events can also be surfaced through Amazon EventBridge.

### AWS IAM
Use IAM roles for services (for example, the AWS Backup service role) and avoid embedding access keys on instances or in code.

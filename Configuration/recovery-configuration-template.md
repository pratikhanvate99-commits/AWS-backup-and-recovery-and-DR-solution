# Recovery Configuration Template

Use this template to define recovery objectives and per-scenario settings. **Targets** are decisions; **achieved** values must come from real tests. Leave `<TBD>` rather than guessing.

## 1. Recovery objectives

| Workload / Tier | RPO target | RTO target | Achieved RPO (tested) | Achieved RTO (tested) | Last test date |
|-----------------|-----------|-----------|-----------------------|-----------------------|----------------|
| `<WORKLOAD>` | `<TBD>` | `<TBD>` | `<TBD>` | `<TBD>` | `<TBD>` |

## 2. Recovery targets

| Item | Value |
|------|-------|
| Primary region | `<PRIMARY_REGION>` |
| Recovery region / AZ | `<RECOVERY_REGION_OR_AZ>` |
| Recovery VPC / subnet | `<VPC_NAME>` / `<SUBNET_NAME>` |
| Security group for restored resources | `<SG_NAME>` |
| Instance type for recovery | `<INSTANCE_TYPE>` |
| IAM instance profile | `<PROFILE_NAME>` |
| Traffic switch method (DNS, Elastic IP, load balancer) | `<METHOD>` |

## 3. Scenario matrix

| Scenario | Recovery source | Approver | Estimated steps | Runbook |
|----------|-----------------|----------|-----------------|---------|
| EC2 failure | `<AMI_OR_RECOVERY_POINT>` | `<NAME>` | `<STEPS>` | [07 - S1](../Documentation/07-recovery-procedures.md#s1-ec2-instance-failure) |
| EBS loss | `<SNAPSHOT_POLICY>` | `<NAME>` | `<STEPS>` | [07 - S2](../Documentation/07-recovery-procedures.md#s2-ebs-volume-corruption-or-loss) |
| S3 deletion | `<VERSIONING_OR_BACKUP>` | `<NAME>` | `<STEPS>` | [07 - S3](../Documentation/07-recovery-procedures.md#s3-accidental-s3-deletion-or-overwrite) |
| AZ/Region outage | `<CROSS_REGION_COPY_OR_NONE>` | `<NAME>` | `<STEPS>` | [07 - S4](../Documentation/07-recovery-procedures.md#s4-availability-zone-or-region-outage) |

## 4. Contacts

| Role | Name | Contact method (do not publish personal data) |
|------|------|-----------------------------------------------|
| Incident owner | Prateek Hanvate | `<PRIVATE>` |
| Alternate | `<NAME>` | `<PRIVATE>` |

## 5. Dependencies

List external dependencies (DNS provider, third-party APIs, licences): `<DEPENDENCIES>`.

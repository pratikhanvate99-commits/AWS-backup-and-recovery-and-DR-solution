# 06 - Disaster Recovery Plan

## 1. DR strategy

This project follows a **Backup and Restore** strategy, the most cost-efficient of the common AWS DR patterns. Recovery resources are created from backups when needed. Other patterns (Pilot Light, Warm Standby, Multi-site Active/Active) offer faster recovery at higher cost and are listed as future scope in [`11-limitations-and-future-scope.md`](11-limitations-and-future-scope.md).

## 2. Disaster scenarios

| # | Scenario | Example cause | Primary recovery method | Procedure |
|---|----------|---------------|-------------------------|-----------|
| S1 | EC2 instance failure | Host fault, OS failure, termination | Launch new instance from AMI/recovery point | [07 - S1](07-recovery-procedures.md#s1-ec2-instance-failure) |
| S2 | EBS volume corruption or loss | File-system damage, accidental detach/delete | Create volume from snapshot and attach | [07 - S2](07-recovery-procedures.md#s2-ebs-volume-corruption-or-loss) |
| S3 | Accidental S3 object deletion/overwrite | Human error, script bug | Restore previous object version or backup | [07 - S3](07-recovery-procedures.md#s3-accidental-s3-deletion-or-overwrite) |
| S4 | Availability Zone outage | AZ-level impairment | Restore into another AZ | [07 - S4](07-recovery-procedures.md#s4-availability-zone-or-region-outage) |
| S5 | Region outage | Regional impairment | Restore in recovery region (needs cross-region copy) | [07 - S4](07-recovery-procedures.md#s4-availability-zone-or-region-outage) |
| S6 | Ransomware / malicious deletion | Compromised credentials | Restore from isolated/immutable recovery point; rotate credentials | [07 - S5](07-recovery-procedures.md#s5-security-incident-or-ransomware) |

## 3. Roles and responsibilities

| Role | Person | Responsibility |
|------|--------|----------------|
| Incident owner | Prateek Hanvate (`<CONFIRM>`) | Declares incident, makes recovery decisions |
| Operator | `<NAME>` | Executes restore procedures |
| Communications | `<NAME>` | Informs stakeholders |

## 4. Objectives (to be filled with real values)

| Objective | Target | Measured in last test |
|-----------|--------|-----------------------|
| RPO | `<TARGET>` | `<MEASURED>` |
| RTO | `<TARGET>` | `<MEASURED>` |

## 5. Activation criteria

Declare a disaster when a scenario above causes service unavailability or data loss that cannot be fixed by normal operations within `<ACCEPTABLE_OUTAGE_WINDOW>`.

## 6. Communication

1. Notify stakeholders via `<CHANNEL>`.
2. Provide status updates every `<INTERVAL>`.
3. Announce resolution and next steps.

## 7. Post-incident review

After each real incident or test, record: timeline, root cause, what worked, what failed, measured recovery time, data loss, and improvements. Update runbooks and the [CHANGELOG](../CHANGELOG.md).

## 8. Plan maintenance

Review this plan at least `<REVIEW_FREQUENCY>` and after every significant infrastructure change.

# 07 - Recovery Procedures

Console-based runbooks for each scenario in [`06-disaster-recovery-plan.md`](06-disaster-recovery-plan.md). **Always restore to new resources first** and validate before switching production traffic. Never delete the damaged resource until recovery is confirmed.

Common checklist before any restore:

- [ ] Incident declared and logged (time, scenario, owner).
- [ ] Latest healthy recovery point identified.
- [ ] Target region/AZ confirmed: `<TARGET_REGION>` / `<TARGET_AZ>`.
- [ ] Security group, subnet and IAM role for the restored resource decided.

## S1: EC2 instance failure

1. **EC2 > Instances**: note the failed instance's configuration (type, subnet, security group, tags).
2. **AWS Backup > Backup vaults > `<VAULT_NAME>`** (or **EC2 > AMIs**): choose the latest suitable recovery point/AMI.
3. Choose **Restore** (or **Launch instance from AMI**) and set instance type, subnet, security group and key pair to match the original.
4. Restore to a **new** instance; optionally stop (not terminate) the failed one for investigation.
5. Validate (see [`09-testing-and-validation.md`](09-testing-and-validation.md)).
6. Re-associate Elastic IP / update DNS / target groups if used: `<TRAFFIC_SWITCH_METHOD>`.

## S2: EBS volume corruption or loss

1. **EC2 > Elastic Block Store > Snapshots**: find the latest healthy snapshot of the volume.
2. **Actions > Create volume from snapshot** in the **same AZ** as the instance; select the right type and encryption.
3. Stop the instance, detach the damaged volume (keep it for investigation), attach the new volume with the original device name.
4. Start the instance, check the file system and application data.
5. Validate and document.

## S3: Accidental S3 deletion or overwrite

1. **S3 > `<BUCKET_NAME>` > Objects**; enable **Show versions**.
2. For an overwrite, open the object and select the previous version, then download/copy it back as the current version.
3. For a deletion with versioning, remove the **delete marker** to restore the previous version.
4. If versioning was not enabled, restore from the backup copy: `<S3_BACKUP_LOCATION>`.
5. Validate object integrity (size, checksum, application test).

## S4: Availability Zone or region outage

1. Confirm the outage on the AWS Health Dashboard.
2. **AZ outage:** restore the EC2/EBS recovery points into a subnet in a different AZ (EBS snapshots are regional, so a volume can be created in another AZ of the same region).
3. **Region outage:** requires a recovery point or S3 data **copied to the recovery region beforehand** (cross-region copy). If this was *not* implemented, region-level recovery is not possible until the region is restored - see [`11-limitations-and-future-scope.md`](11-limitations-and-future-scope.md).
4. Recreate required networking in `<RECOVERY_REGION>`: VPC, subnet, security group.
5. Restore, validate, and update DNS/traffic routing.

## S5: Security incident or ransomware

1. **Contain:** isolate affected resources (restrictive security group), disable compromised credentials, rotate access keys.
2. **Preserve evidence:** snapshot affected volumes before changes.
3. **Select** a recovery point from **before** the compromise time.
4. Restore to a clean, isolated environment; scan and validate.
5. Review IAM, CloudTrail, and access policies; apply fixes before reconnecting.

## After recovery

- [ ] Service validated and traffic restored.
- [ ] Measured recovery time and data loss recorded.
- [ ] Temporary resources cleaned up (only after approval).
- [ ] Post-incident review completed.
- [ ] Documentation updated.

> Example helper: [`../Scripts/restore-example.sh`](../Scripts/restore-example.sh) prints a dry-run plan; it does not delete anything.

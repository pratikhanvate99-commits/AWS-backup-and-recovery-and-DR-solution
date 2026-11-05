# 09 - Testing and Validation

> **No results are claimed here.** This document defines *how* to test. Record your real observations in the results table. Do not enter values you did not measure.

## 1. Test types

| Test | Goal | Frequency |
|------|------|-----------|
| Backup job verification | Jobs complete and recovery points exist | after each scheduled run / daily review |
| Restore test (EC2/EBS) | Restored instance boots and data is intact | `<FREQUENCY>` |
| Restore test (S3) | Previous version / backup can be recovered | `<FREQUENCY>` |
| Alert test | CloudWatch alarm triggers SNS notification | after setup and after changes |
| Access test | Backup operators can restore; others cannot delete | after IAM changes |

## 2. Restore test procedure

1. Choose a recovery point and note its creation time.
2. Restore to a **new, isolated** resource (do not overwrite production).
3. Start a timer when the restore begins; stop when the service passes validation.
4. Run the validation checklist below.
5. Record results and clean up test resources (after confirming nothing else depends on them).

## 3. Validation checklist

- [ ] Instance reaches *running* and passes 2/2 status checks.
- [ ] Operating system and application start correctly.
- [ ] Expected files/data are present; sample checksum or record count matches.
- [ ] Network access works as intended (security group, subnet).
- [ ] Monitoring/alarms attached to the restored resource.
- [ ] Application owner signs off.

## 4. Results log (owner to complete)

| Date | Scenario | Recovery point | Measured restore time | Data loss window | Result | Notes |
|------|----------|----------------|-----------------------|------------------|--------|-------|
| `<DATE>` | `<S1-S5>` | `<RP_TIME>` | `<MEASURED>` | `<MEASURED>` | `<PASS/FAIL>` | `<NOTES>` |

Evidence: add redacted screenshots to [`../Screenshots/Recovery/`](../Screenshots/Recovery/README.md).

## 5. Alert test

1. Temporarily lower an alarm threshold or use `aws cloudwatch set-alarm-state` on a *test* alarm.
2. Confirm that the SNS email arrives.
3. Restore the alarm configuration.

## 6. Continuous improvement

Each test should produce at least one note on how to speed up or simplify recovery.

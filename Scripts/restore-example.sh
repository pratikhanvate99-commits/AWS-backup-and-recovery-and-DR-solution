#!/usr/bin/env bash
# =============================================================================
# EXAMPLE ONLY - not used in the original project.
# Purpose : Inspect a recovery point and print a manual restore plan.
# Safety  : READ-ONLY. This script NEVER starts a restore and NEVER deletes or
#           overwrites anything. Perform the actual restore deliberately via the
#           AWS Console or after your own review (see Documentation/07).
# =============================================================================
set -euo pipefail

: "${AWS_REGION:?Set AWS_REGION}"
: "${BACKUP_VAULT_NAME:?Set BACKUP_VAULT_NAME}"
: "${RECOVERY_POINT_ARN:?Set RECOVERY_POINT_ARN}"

command -v aws >/dev/null 2>&1 || { echo "ERROR: AWS CLI not found." >&2; exit 1; }

echo "== Recovery point details (read-only) =="
aws backup describe-recovery-point \
  --region "$AWS_REGION" \
  --backup-vault-name "$BACKUP_VAULT_NAME" \
  --recovery-point-arn "$RECOVERY_POINT_ARN" \
  --query '{Status:Status,ResourceType:ResourceType,Created:CreationDate,SizeBytes:BackupSizeInBytes,Encrypted:IsEncrypted}' \
  --output table

echo
echo "== Restore metadata (read-only) =="
aws backup get-recovery-point-restore-metadata \
  --region "$AWS_REGION" \
  --backup-vault-name "$BACKUP_VAULT_NAME" \
  --recovery-point-arn "$RECOVERY_POINT_ARN" \
  --output json

cat <<'PLAN'

== Manual restore plan (nothing has been executed) ==
 1. Confirm the incident and the chosen recovery point time with the incident owner.
 2. Decide the target: new resource, correct region/AZ, subnet, security group, IAM role.
 3. Restore to a NEW resource via AWS Backup > Protected resources > Restore
    (or EC2 > Snapshots/AMIs), reviewing the metadata printed above.
 4. Validate the restored resource (Documentation/09-testing-and-validation.md).
 5. Switch traffic only after validation passes.
 6. Keep the damaged resource until recovery is confirmed; clean up later with approval.
PLAN

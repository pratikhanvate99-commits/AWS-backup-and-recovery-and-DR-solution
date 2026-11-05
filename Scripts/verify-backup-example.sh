#!/usr/bin/env bash
# =============================================================================
# EXAMPLE ONLY - not used in the original project.
# Purpose : Read-only backup verification: recent recovery points exist and
#           no backup jobs are in FAILED state.
# Safety  : Only list APIs. Changes nothing.
# Note    : A passing check does NOT replace a real restore test.
# =============================================================================
set -euo pipefail

: "${AWS_REGION:?Set AWS_REGION}"
: "${BACKUP_VAULT_NAME:?Set BACKUP_VAULT_NAME}"
MAX_BACKUP_AGE_HOURS="${MAX_BACKUP_AGE_HOURS:-}"

command -v aws >/dev/null 2>&1 || { echo "ERROR: AWS CLI not found." >&2; exit 1; }
exit_code=0

echo "== Most recent recovery points in vault '$BACKUP_VAULT_NAME' =="
aws backup list-recovery-points-by-backup-vault \
  --region "$AWS_REGION" --backup-vault-name "$BACKUP_VAULT_NAME" \
  --query 'sort_by(RecoveryPoints,&CreationDate)[-5:].{Created:CreationDate,Status:Status,Type:ResourceType,Encrypted:IsEncrypted}' \
  --output table

latest=$(aws backup list-recovery-points-by-backup-vault \
  --region "$AWS_REGION" --backup-vault-name "$BACKUP_VAULT_NAME" \
  --query 'max_by(RecoveryPoints,&CreationDate).CreationDate' --output text 2>/dev/null || echo "None")

if [[ -z "$latest" || "$latest" == "None" ]]; then
  echo "WARNING: no recovery points found."
  exit_code=1
elif [[ -n "$MAX_BACKUP_AGE_HOURS" ]]; then
  latest_epoch=$(date -d "$latest" +%s 2>/dev/null || echo 0)
  now_epoch=$(date +%s)
  age_hours=$(( (now_epoch - latest_epoch) / 3600 ))
  echo "Latest recovery point age: ${age_hours}h (threshold: ${MAX_BACKUP_AGE_HOURS}h)"
  if (( age_hours > MAX_BACKUP_AGE_HOURS )); then
    echo "WARNING: latest recovery point is older than the threshold."
    exit_code=1
  fi
else
  echo "Latest recovery point: $latest (set MAX_BACKUP_AGE_HOURS to enforce a freshness check)"
fi

echo
echo "== Backup jobs in FAILED / EXPIRED state =="
bad=$(aws backup list-backup-jobs --region "$AWS_REGION" --by-state FAILED \
  --query 'BackupJobs[].BackupJobId' --output text)
if [[ -n "$bad" ]]; then
  echo "Failed job IDs: $bad"
  exit_code=1
else
  echo "No failed jobs returned."
fi

exit "$exit_code"

#!/usr/bin/env bash
# =============================================================================
# EXAMPLE ONLY - not used in the original project.
# Purpose : Start an on-demand AWS Backup job for one resource.
# Safety  : Defaults to DRY_RUN=true (prints the command, changes nothing).
#           Contains no credentials and no delete/terminate operations.
# Requires: AWS CLI v2, authenticated session, variables below.
# =============================================================================
set -euo pipefail

: "${AWS_REGION:?Set AWS_REGION (see Configuration/environment-template.md)}"
: "${BACKUP_VAULT_NAME:?Set BACKUP_VAULT_NAME}"
: "${RESOURCE_ARN:?Set RESOURCE_ARN}"
: "${BACKUP_ROLE_ARN:?Set BACKUP_ROLE_ARN}"
DRY_RUN="${DRY_RUN:-true}"
RETENTION_DAYS="${RETENTION_DAYS:-}"   # optional; empty = use vault/plan defaults

command -v aws >/dev/null 2>&1 || { echo "ERROR: AWS CLI not found." >&2; exit 1; }

cmd=(aws backup start-backup-job
  --region "$AWS_REGION"
  --backup-vault-name "$BACKUP_VAULT_NAME"
  --resource-arn "$RESOURCE_ARN"
  --iam-role-arn "$BACKUP_ROLE_ARN")

if [[ -n "$RETENTION_DAYS" ]]; then
  cmd+=(--lifecycle "DeleteAfterDays=${RETENTION_DAYS}")
fi

echo "Backup request"
echo "  Region : $AWS_REGION"
echo "  Vault  : $BACKUP_VAULT_NAME"
echo "  Dry run: $DRY_RUN"

if [[ "$DRY_RUN" == "true" ]]; then
  echo "[DRY RUN] Would execute:"
  printf '  %q' "${cmd[@]}"; echo
  echo "Set DRY_RUN=false to create the backup job."
  exit 0
fi

"${cmd[@]}"
echo "Backup job submitted. Monitor it in AWS Backup > Jobs."

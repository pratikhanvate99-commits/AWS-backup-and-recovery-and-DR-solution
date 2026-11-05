#!/usr/bin/env bash
# =============================================================================
# EXAMPLE ONLY - not used in the original project.
# Purpose : Read-only health report for an EC2 instance and CloudWatch alarms.
# Safety  : Only uses describe/list APIs. Changes nothing.
# =============================================================================
set -euo pipefail

: "${AWS_REGION:?Set AWS_REGION}"
: "${INSTANCE_ID:?Set INSTANCE_ID}"

command -v aws >/dev/null 2>&1 || { echo "ERROR: AWS CLI not found." >&2; exit 1; }
exit_code=0

echo "== EC2 instance state =="
aws ec2 describe-instances --region "$AWS_REGION" --instance-ids "$INSTANCE_ID" \
  --query 'Reservations[].Instances[].{Id:InstanceId,State:State.Name,Type:InstanceType,AZ:Placement.AvailabilityZone}' \
  --output table

echo
echo "== EC2 status checks =="
status=$(aws ec2 describe-instance-status --region "$AWS_REGION" --instance-ids "$INSTANCE_ID" \
  --include-all-instances \
  --query 'InstanceStatuses[0].[InstanceStatus.Status,SystemStatus.Status]' --output text)
echo "Instance / System status: $status"
if ! grep -q '^ok[[:space:]]ok$' <<<"$status"; then
  echo "WARNING: status checks are not both 'ok'."
  exit_code=1
fi

echo
echo "== CloudWatch alarms currently in ALARM =="
alarms=$(aws cloudwatch describe-alarms --region "$AWS_REGION" --state-value ALARM \
  --query 'MetricAlarms[].AlarmName' --output text)
if [[ -n "$alarms" ]]; then
  echo "$alarms" | tr '\t' '\n'
  exit_code=1
else
  echo "None."
fi

echo
echo "== EBS volumes attached to the instance =="
aws ec2 describe-volumes --region "$AWS_REGION" \
  --filters "Name=attachment.instance-id,Values=${INSTANCE_ID}" \
  --query 'Volumes[].{Id:VolumeId,State:State,SizeGiB:Size,Encrypted:Encrypted}' --output table

if [[ $exit_code -eq 0 ]]; then
  echo; echo "Health check finished: no issues detected by this script."
else
  echo; echo "Health check finished: attention required."
fi
exit "$exit_code"

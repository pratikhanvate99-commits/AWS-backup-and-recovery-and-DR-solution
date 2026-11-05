# Backup Policy Template

Copy this file, fill in the placeholders and keep the completed version **private or sanitised** if it contains sensitive details. Do not invent values; leave `<TBD>` if undecided.

## 1. Policy metadata

| Field | Value |
|-------|-------|
| Policy name | `<POLICY_NAME>` |
| Owner | Prateek Hanvate |
| Version / date | `<VERSION>` / `<DATE>` |
| Review frequency | `<REVIEW_FREQUENCY>` |

## 2. Protected resources

| Resource | Selection method (tag or ID) | Criticality |
|----------|------------------------------|-------------|
| `<RESOURCE>` | `<TAG_KEY>=<TAG_VALUE>` | `<HIGH/MEDIUM/LOW>` |

## 3. Backup rules

| Rule name | Schedule (cron/rate) | Start window | Complete window | Lifecycle (cold storage) | Retention | Destination vault | Copy to region/account |
|-----------|---------------------|--------------|-----------------|--------------------------|-----------|-------------------|------------------------|
| `<RULE_1>` | `<SCHEDULE>` | `<WINDOW>` | `<WINDOW>` | `<DAYS_OR_NONE>` | `<DAYS>` | `<VAULT_NAME>` | `<NONE_OR_TARGET>` |

## 4. Protection settings

| Setting | Value |
|---------|-------|
| Encryption key | `<KMS_KEY_ALIAS>` |
| Vault access policy / lock | `<DESCRIBE_OR_NONE>` |
| Backup service role | `<ROLE_NAME>` |
| S3 versioning | `<ENABLED/DISABLED>` |

## 5. Monitoring and notification

| Item | Value |
|------|-------|
| Failed-job alert destination | `<SNS_TOPIC_NAME>` |
| Review cadence of job reports | `<CADENCE>` |

## 6. Verification

- Restore test frequency: `<FREQUENCY>`
- Last successful restore test: `<DATE_OR_NONE>`
- Responsible person: `<NAME>`

## 7. Exceptions and approvals

`<DOCUMENT_ANY_EXCEPTIONS>`

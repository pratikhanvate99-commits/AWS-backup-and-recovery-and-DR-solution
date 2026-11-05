# 11 - Limitations and Future Scope

## 1. Limitations of the current approach

| Limitation | Impact |
|------------|--------|
| **Manual Console configuration** | Environment is not reproducible from code; risk of configuration drift and human error |
| **Backup and Restore strategy** | Recovery time is longer than warm-standby or active/active designs because resources are rebuilt on demand |
| **Single-region protection (unless cross-region copy was implemented)** | A regional outage may prevent recovery until the region returns |
| **Manual restore steps** | Recovery speed depends on operator availability and skill |
| **No automated restore testing** | Validation depends on scheduled manual tests |
| **Scripts are examples only** | They have not been used operationally and must be reviewed and tested before any real use |

## 2. Proposed enhancements (not implemented)

| Priority | Enhancement | Benefit |
|----------|-------------|---------|
| High | Cross-region and/or cross-account backup copy | Protection from regional outage and account compromise |
| High | Infrastructure as Code (Terraform or CloudFormation) | Reproducible, reviewable infrastructure and faster rebuilds |
| High | Scheduled automated restore tests | Continuous evidence that backups are usable |
| Medium | AWS Backup Vault Lock / S3 Object Lock | Immutability against ransomware and accidental deletion |
| Medium | EventBridge + Lambda automation for backup failure handling and reporting | Faster response, less manual work |
| Medium | Pilot Light / Warm Standby architecture | Lower RTO |
| Medium | Route 53 health checks and failover routing | Automated traffic failover |
| Low | AWS Backup Audit Manager | Compliance reporting |
| Low | CI/CD pipeline for documentation and policy validation | Quality control (basic checks provided in `.github/workflows`) |

## 3. Roadmap suggestion

1. Complete restore testing and record real RTO/RPO.
2. Add cross-region copy.
3. Codify the infrastructure with IaC.
4. Automate monitoring and restore verification.

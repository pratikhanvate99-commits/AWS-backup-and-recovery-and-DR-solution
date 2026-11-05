# Disaster Recovery Workflow

This workflow describes the generic *backup and restore* DR process for the project. Time targets are intentionally **not** stated; define them in [`../Configuration/recovery-configuration-template.md`](../Configuration/recovery-configuration-template.md) after measuring real restore tests.

```mermaid
flowchart TD
    A([Incident detected]) --> B{Source of detection}
    B -- "CloudWatch alarm / SNS" --> C[Operator notified]
    B -- "User report / manual check" --> C
    C --> D[Assess impact and classify incident]
    D --> E{Disaster scenario}
    E -- "Instance failure" --> F1[Restore EC2 from AMI or snapshot]
    E -- "Volume corruption / data loss" --> F2[Create volume from EBS snapshot]
    E -- "Accidental S3 deletion" --> F3[Recover object version or restore from backup]
    E -- "Region or AZ outage" --> F4[Restore in alternate AZ or region]
    F1 --> G[Validate restored resource]
    F2 --> G
    F3 --> G
    F4 --> G
    G --> H{Validation passed?}
    H -- "No" --> I[Select earlier recovery point]
    I --> E
    H -- "Yes" --> J[Redirect users / resume service]
    J --> K[Monitor stability]
    K --> L[Post-incident review]
    L --> M([Update runbooks and backup policy])
```

## Phases

| Phase | Goal | Reference |
|-------|------|-----------|
| 1. Detect | Identify the incident quickly | [`../Documentation/09-testing-and-validation.md`](../Documentation/09-testing-and-validation.md) |
| 2. Assess | Determine scope, data-loss window and scenario | [`../Documentation/06-disaster-recovery-plan.md`](../Documentation/06-disaster-recovery-plan.md) |
| 3. Recover | Restore from the most suitable recovery point | [`../Documentation/07-recovery-procedures.md`](../Documentation/07-recovery-procedures.md) |
| 4. Validate | Confirm integrity and function | [`../Documentation/09-testing-and-validation.md`](../Documentation/09-testing-and-validation.md) |
| 5. Review | Capture lessons learned | [`../Documentation/06-disaster-recovery-plan.md`](../Documentation/06-disaster-recovery-plan.md) |

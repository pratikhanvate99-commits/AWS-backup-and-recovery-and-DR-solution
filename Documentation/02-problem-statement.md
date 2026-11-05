# 02 - Problem Statement

## Why organisations need backup and DR

Systems fail. Typical causes include:

- **Hardware or instance failure** - an EC2 host or storage device becomes unavailable.
- **Human error** - accidental deletion or misconfiguration of resources or objects.
- **Software faults and corruption** - bad deployments, corrupted databases or file systems.
- **Malicious activity** - ransomware, credential compromise, insider misuse.
- **Natural or infrastructure disasters** - power, network or Availability Zone / region outages.

Without tested backups and a recovery plan, these events can cause prolonged downtime, permanent data loss, financial damage, regulatory exposure and loss of customer trust.

## Problem addressed by this project

A workload running on AWS needs:

1. A reliable way to create **independent, restorable copies** of its data and system state.
2. A **documented, repeatable procedure** to restore after failure.
3. **Visibility** (monitoring and alerts) into whether backups and the workload are healthy.
4. **Controlled cost and access** so the protection itself does not become a risk.

## Objectives

| # | Objective |
|---|-----------|
| 1 | Protect EC2/EBS and S3 data using scheduled backups |
| 2 | Retain recovery points according to a defined retention policy |
| 3 | Define recovery procedures for common disaster scenarios |
| 4 | Monitor backup and resource health |
| 5 | Secure backups with IAM least privilege and encryption |
| 6 | Optimise storage cost through lifecycle management |
| 7 | Validate recovery through restore testing |

## Success criteria

Success criteria must be defined by the owner and based on **measured** results, for example:

- Restore test completed successfully on `<DATE>`.
- Measured recovery time for `<SCENARIO>`: `<MEASURED_VALUE>`.
- Data loss window observed: `<MEASURED_VALUE>`.

> No RTO/RPO values are asserted in this repository. Record real values only after testing.

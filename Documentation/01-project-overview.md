# 01 - Project Overview

**Project:** AWS Disaster Recovery & Backup Solution
**Owner:** Prateek Hanvate
**Implementation method:** AWS Management Console (manual configuration)
**Category:** AWS Cloud Computing, Backup, Disaster Recovery, DevOps

## What is disaster recovery?

Disaster recovery (DR) is the set of policies, tools and procedures that allow an organisation to restore IT systems and data after a disruptive event, such as hardware failure, human error, data corruption, ransomware, or a regional outage. DR is a subset of *business continuity*: continuity keeps the business operating, while DR focuses on bringing technology back.

## Purpose of this project

This project designs and documents a cloud-based backup and disaster recovery approach on AWS. Its goals are to:

1. Protect compute and storage resources with regular, retrievable backups.
2. Define how to restore services after a failure.
3. Monitor the environment and be notified of problems.
4. Apply security and cost-control practices.
5. Document the work so it can be reviewed, repeated and improved.

## Scope

| In scope | Out of scope |
|----------|--------------|
| Backup of EC2/EBS and S3 data | Application-level code |
| Documented restore procedures | Automated provisioning (IaC) |
| Monitoring and alerting design | Multi-account governance |
| Security and cost guidance | Fabricated performance or cost numbers |

## How the infrastructure was built

All resources were created and configured **manually through the AWS Management Console**. No Terraform, CloudFormation, CDK or other Infrastructure as Code was used. The `Scripts/` folder contains *illustrative examples only*; they were **not** used to build or operate the original project.

## Implementation status

Complete this table before publishing so that the repository stays truthful.

| Capability | Status (Implemented / Partial / Proposed) | Notes |
|------------|-------------------------------------------|-------|
| EC2 primary workload | `<CONFIRM>` | |
| EBS volumes and snapshots | `<CONFIRM>` | |
| S3 bucket(s) | `<CONFIRM>` | |
| AWS Backup plan and vault | `<CONFIRM>` | |
| IAM roles / policies | `<CONFIRM>` | |
| VPC / security groups | `<CONFIRM>` | |
| CloudWatch metrics / alarms | `<CONFIRM>` | |
| SNS notifications | `<CONFIRM>` | |
| Lambda automation | `<CONFIRM>` | |
| Cross-region copy | `Proposed` | |
| Restore test performed | `<CONFIRM>` | |

## Repository map

See the [README](../README.md) for the directory structure and the [architecture](../Architecture/aws-architecture.md) for diagrams.

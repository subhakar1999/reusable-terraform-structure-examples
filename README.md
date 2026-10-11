# Terraform — Reusable & Secure Infrastructure-as-Code Framework

[![Live Demo](https://img.shields.io/badge/Live%20Demo-Vercel%20Preview-000000?style=for-the-badge&logo=vercel&logoColor=white)](https://reusable-terraform-structure-exampl.vercel.app)
[![Terraform >= 1.9](https://img.shields.io/badge/terraform-%3E%3D1.9-844FBA.svg)](https://www.terraform.io/)
[![AWS Provider ~> 5.0](https://img.shields.io/badge/aws%20provider-~%3E5.0-FF9900.svg)](https://registry.terraform.io/providers/hashicorp/aws/latest)
[![Security Scans](https://img.shields.io/badge/scans-checkov%20%7C%20tfsec-22c55e.svg)](policies/)

A production-grade Terraform project layout focused on **reusability** (modules + environments) and **security** (least-privilege IAM, remote encrypted state, secrets handling, policy-as-code, CI/CD scanning).

---

## 🌐 Live Interactive Architecture & Code Explorer (Vercel)

👉 **Live Portal URL**: **[https://reusable-terraform-structure-exampl.vercel.app](https://reusable-terraform-structure-exampl.vercel.app)**

This repository includes a pre-configured interactive web portal (`index.html`, `vercel.json`, and `package.json`) allowing viewers to explore the cloud architecture, review module code, compare environments, and simulate CLI commands in real time.

### Deploy to Vercel in 1 Click:
1. Import this repository in [Vercel Dashboard](https://vercel.com/new).
2. Click **Deploy** (zero configuration required).

Or deploy instantly via CLI:
```bash
npx vercel --prod
```

## Design principles

| Concern | How it's addressed |
|---|---|
| Reusability | Small, composable modules; env-specific config only in `environments/` |
| Security | Remote state (S3 + DynamoDB lock), KMS encryption, no secrets in code |
| Consistency | Pinned provider/module versions, `locals` for naming/tags |
| Compliance | Policy-as-code (Checkov/tfsec), pre-commit hooks, CI scans |

## Layout

```
terraform/
├── environments/          # One folder per environment — thin wrappers over modules
│   ├── dev/
│   ├── staging/
│   └── prod/
├── modules/               # Reusable, versioned, environment-agnostic modules
│   ├── vpc/
│   ├── ec2/
│   ├── s3/
│   └── iam/
├── shared/                # Backend, provider, tagging config
├── policies/              # Policy-as-code checks
├── scripts/               # Automation helpers
└── .github/workflows/     # CI/CD: fmt/validate/plan, security scan, apply on merge
```

## Typical workflow

```bash
cd environments/dev
terraform init
terraform plan -var-file="dev.tfvars"
terraform apply -var-file="dev.tfvars" -auto-approve
```

## Security highlights

1. **State**: stored in S3, encrypted with KMS, locked via DynamoDB — never local.
2. **Secrets**: injected via env vars / CI OIDC — never committed; `.gitignore` blocks `*.tfvars` (except examples).
3. **IAM**: least-privilege roles assumed via OIDC in CI (no long-lived access keys).
4. **Scanning**: `checkov` + `tfsec` run on every PR; merges blocked on criticals.

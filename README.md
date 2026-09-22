# Terraform — Reusable & Secure Infrastructure-as-Code Framework

A production-grade Terraform project layout focused on **reusability** (modules + environments) and **security** (least-privilege IAM, remote encrypted state, secrets handling, policy-as-code, CI/CD scanning).

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

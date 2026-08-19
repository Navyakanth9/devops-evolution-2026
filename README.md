# 🏗️ Automated GitOps Enterprise Web Architecture via Terraform & GitHub Actions

Welcome to my production-grade infrastructure repository, built as part of my **12-Week DevOps & Platform Engineering Evolution Journey**. This project demonstrates the complete transition from local, hardcoded infrastructure configuration to a fully parameterized, modularized, and automated **GitOps CI/CD Pipeline**.

---

## 🗺️ Architectural Topology

The automation pipeline securely provisions a highly available, isolated cloud environment inside the **AWS Hyderabad (`ap-south-2`)** data center region:

```text
       [ Public Internet Explorer / Curl ]
                       │
                       ▼ (Inbound Traffic: Port 80 / Port 22)
     ┌────────────────────────────────────────────────────────┐
     │ AWS VPC: Boundary Land Isolation (10.0.0.0/16)          │
     │   │                                                    │
     │   ▼ Internet Gateway: The Public Portal Edge Entrance  │
     │   ┌────────────────────────────────────────────────┐   │
     │   │ Route Table: Dynamic Highway Routing Map       │   │
     │   └────────────────────────┬───────────────────────┘   │
     │                            ▼                           │
     │   ┌────────────────────────────────────────────────┐   │
     │   │ Public Subnet Layer (10.0.1.0/24)              │   │
     │   │   │                                            │   │
     │   │   ▼ Stateful Security Group Firewall Gates     │   │
     │   │   ┌────────────────────────────────────────┐   │   │
     │   │   │ Amazon EC2 Engine: Apache Web Server   │   │   │
     │   │   │  - OpenSSH Key Pair Auth (Port 22)     │   │   │
     │   │   │  - Live HTTP Splashtag (Port 80)       │   │   │
     │   │   └────────────────────────────────────────┘   │   │
     │   └────────────────────────────────────────────────┘   │
     └────────────────────────────────────────────────────────┘
```

---

## 🛠️ Repository Structural Tree

This repository implements **Strict Encapsulation Isolation Best Practices**. The root module serves purely as a variable-driven wrapper interface, passing environment values down into the underlying core module capsule:

```text
.
├── .github/
│   └── workflows/
│       └── devops-pipeline.yml  # Passwordless OIDC GitHub Actions CI/CD Pipeline
├── modules/
│   └── enterprise_web_app/      # Encapsulated Architecture Child Module Capsule
│       ├── main.tf              # Deploys 8 AWS Physical Network & Compute Resources
│       ├── variables.tf         # Child Module Variable Contracts
│       ├── outputs.tf           # Child Module Outbound Pipeline Mapping
│       └── web-server.bash      # Native Linux (LF) Bootstrapping Shell Script
├── main.tf                      # Root Wrapper Module (Backend S3 + Providers)
├── variables.tf                 # Root Input Parameters
├── outputs.tf                   # Multi-Layer Root Outbound Data Dashboard Panel
├── terraform.tfvars             # Environment Raw Override Variables
└── .gitignore                   # Excludes state files, local cache, and private secrets
```

---

## 🔒 Security Architecture: Zero-Secret OIDC Governance

To ensure enterprise-grade threat modeling, this pipeline implements **Zero-Secret Identity Federation**. 

* **The Mechanism:** Static keys (`AWS_ACCESS_KEY_ID`) are entirely omitted from GitHub Secrets. Instead, GitHub Actions establishes a passwordless handshake with AWS STS using **OpenID Connect (OIDC)**.
* **Modern Compliance (Post-July 2026):** The AWS IAM Trust Policy is engineered to handle GitHub’s mandatory **Immutable Subject Claims (`sub`)** update. It matches against secure wildcard patterns to prevent namespace hijacking and malicious role reuse.

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::955030484164:oidc-provider/://githubusercontent.com"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "://githubusercontent.com:aud": "://amazonaws.com"
        },
        "StringLike": {
          "://githubusercontent.com:sub": "repo:*:devops-evolution-2026:*"
        }
      }
    }
  ]
}
```

---

## 🧠 Real-World Engineering Failure Logs & Debugging Runbooks

The most critical skill demonstrated in this repository is the ability to troubleshoot complex, decoupled systems. Below are the engineering failures encountered and systematically resolved:

### 🚨 Outage 1: Windows Encoding Mismatch (`not valid UTF-8` & `Unhandled userdata`)
* **Symptom:** The Terraform local compiler crashed during `file()` processing, or the EC2 server booted up completely empty with Apache uninstalled.
* **Root Cause Analysis:** The script was saved on a Windows host using `UTF-16 LE` encoding and `CRLF (\r\n)` line endings. Linux fails to read the hidden carriage returns, crashing the `#!/bin/bash\r` shebang line.
* **Resolution:** Re-encoded files to strict **UTF-8** with **Linux LF line breaks**. Configured `git config --global core.autocrlf false` locally to permanently block the Windows Git engine from injecting hidden characters during staging.

### 🚨 Outage 2: The Core Compiler Hook Block (`Unsupported argument`)
* **Symptom:** `terraform init` exited with code 1 inside the remote GitHub Runner environment container.
* **Root Cause Analysis:** The GitHub workflow was explicitly pinned to an older compiler version (v1.7.0). The codebase, however, utilized modern native S3 state locking parameters (`use_lockfile = true`), which were unrecognized by the older compiler.
* **Resolution:** Upgraded the remote installation runner actions layout to `setup-terraform@v3` and bumped the execution engine directly to **v1.10.0** to match current cloud state standards.

### 🚨 Outage 3: Duplicate Metadata Asset Collisions (`InvalidKeyPair.Duplicate`)
* **Symptom:** The automated OIDC deployment workflow threw a code 400 runtime crash when parsing key pairs.
* **Root Cause Analysis:** A transient local testing block crashed and deleted its container disk before writing details to the remote S3 tracking backend. The metadata remained orphaned in the AWS Cloud console, colliding with the next pipeline attempt.
* **Resolution:** Performed a live recovery cycle—manually purging the orphaned key pairs via the AWS console and implementing a clean `terraform destroy -auto-approve` stage to stabilize the state backend baseline.

---

## 📊 Automated Pipeline Operational Sequence

On every single `git push` to the active branch, the pipeline triggers an automated lifecycle execution:
1. **Security Scan**: Checks formatting and validation layers via `terraform fmt`.
2. **Deterministic Planning**: Compiles all configuration files, fetches remote state memory parameters from the secure S3 bucket backend, and saves the binary execution footprint payload to disk (`terraform plan -out=tfplan`).
3. **Immutable Deployment**: Consumes the explicit plan file and applies the updates safely to production (`terraform apply -auto-approve tfplan`).

---
*Developed with focus, muscle-memory typing, and systematic root-cause problem solving.*

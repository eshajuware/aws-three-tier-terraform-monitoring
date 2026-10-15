---

# AWS Three-Tier Architecture with Monitoring (Terraform)

## Tools Required (Windows PowerShell, run as Administrator)

```powershell
winget install -e --id Hashicorp.Terraform
winget install -e --id Git.Git
winget install -e --id Amazon.AWSCLI
```

Close PowerShell, open a new window, and check:

```powershell
terraform -version
git --version
aws --version
```

## Configure AWS Credentials

```powershell
aws configure
aws sts get-caller-identity
```

Region used: `us-east-1`

## Architecture

- VPC with public and private subnets
- Internet Gateway and NAT Gateway
- Security groups for EC2 and RDS
- Auto Scaling Group behind an ALB
- RDS MySQL (Multi-AZ)

## Monitoring

- **SNS:** an email alert topic and subscription (`sns.tf`)
- **CloudWatch:** alarms for ALB 5xx errors, ASG CPU, RDS CPU and RDS free storage, all notifying SNS (`cloudwatch.tf`)
- **Datadog:** AWS integration and monitors for the same signals (`datadog.tf`)

## Deploy

```powershell
$env:TF_VAR_alert_email = "you@example.com"
$env:TF_VAR_datadog_api_key = "YOUR_API_KEY"
$env:TF_VAR_datadog_app_key = "YOUR_APP_KEY"

terraform init
terraform validate
terraform plan
terraform apply
```

Datadog keys and the alert email are passed as environment variables and are never committed.

## Clean up

```powershell
terraform destroy
```

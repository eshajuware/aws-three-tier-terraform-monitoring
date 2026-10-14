data "aws_caller_identity" "current" {}

resource "datadog_integration_aws" "main" {
  account_id = data.aws_caller_identity.current.account_id
  role_name  = "DatadogIntegrationRole"
}

resource "datadog_monitor" "alb_5xx" {
  name    = "ALB 5xx errors high"
  type    = "metric alert"
  message = "ALB is returning 5xx errors."
  query   = "sum(last_5m):sum:aws.applicationelb.httpcode_elb_5xx{*}.as_count() > 10"
}

resource "datadog_monitor" "asg_cpu" {
  name    = "EC2 CPU high"
  type    = "metric alert"
  message = "EC2 CPU above 80%."
  query   = "avg(last_5m):avg:aws.ec2.cpuutilization{*} > 80"
}

resource "datadog_monitor" "rds_cpu" {
  name    = "RDS CPU high"
  type    = "metric alert"
  message = "RDS CPU above 80%."
  query   = "avg(last_5m):avg:aws.rds.cpuutilization{*} > 80"
}
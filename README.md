# README for Datadog AWS Integration Module x CloudFormation Script in S3 Bucket. 

## Overview

This Terraform and AWS CloudFormation deployment solution provisions an S3 bucket, deploys a CloudFormation stack, and sets up a comprehensive Datadog AWS integration. The integration collects AWS metrics, logs, and security posture data into Datadog for enhanced monitoring and security visibility.

***

## Components

### 1. S3 Bucket Module

- **Module Source:** `./cloudformation/s3-bucket`
- **Function:** Creates an S3 bucket which hosts the CloudFormation template.
- **Input Variable:**
  - `bucket_name` - Name of the S3 bucket to be created.
- **Output:**
  - `template_url` - URL pointing to the CloudFormation template hosted on the created S3 bucket.

### 2. CloudFormation Module

- **Module Source:** `./cloudformation`
- **Function:** Deploys the CloudFormation stack using the template URL from the S3 bucket module.
- **Input Variables:**
  - `stack_name` - Name of the CloudFormation stack
  - `template_url` - S3 URL of the CloudFormation template (output from the S3 bucket module)
- **Dependencies:**
  - Depends on the successful creation of the S3 bucket module.

***

## CloudFormation Template Description

- **Version:** v2.2.7
- **Description:** Sets up Datadog AWS Integration enabling collection of metrics, logs, and security posture data.

### Parameters:

| Parameter                   | Description                                                                                           | Default           |
|-----------------------------|---------------------------------------------------------------------------------------------------|-------------------|
| `APIKey`                    | Datadog API key (found in Datadog organization settings)                                          | (No default, sensitive) |
| `APPKey`                    | Datadog Application key (found in Datadog organization settings)                                   | (No default, sensitive) |
| `DatadogSite`               | Datadog site to send data to (e.g., datadoghq.com, us5.datadoghq.com)                             | us5.datadoghq.com |
| `IAMRoleName`               | Custom name for the IAM role created for Datadog integration                                     | DatadogIntegrationRole |
| `InstallLambdaLogForwarder` | Whether to install Datadog Lambda Log Forwarder for shipping logs                                | true              |
| `DisableMetricCollection`   | Disable metric collection if set to true (not recommended to disable unless only tags/resource info needed) | false             |
| `DisableResourceCollection` | Disable resource collection if set to true                                                       | false             |
| `CloudSecurityPostureManagement` | Enable Datadog Cloud Security Posture Management (CSPM)                                        | false             |

### Key Resources:

- **Datadog AWS Account Integration Stack:** Sets up integration-related resources using nested templates.
- **IAM Role:** Creates an IAM role with necessary permissions for Datadog integration.
- **Lambda Forwarder Stack:** (Conditional) Creates a Lambda function for shipping logs and custom metrics to Datadog.

***

## Usage

### Terraform

```hcl
module "s3_bucket" {
  source      = "./cloudformation/s3-bucket"
  bucket_name = var.bucket_name
}

module "cloudformation" {
  source       = "./cloudformation"
  stack_name   = var.stack_name
  template_url = module.s3_bucket.template_url

  depends_on = [module.s3_bucket]
}
```

- Set `bucket_name` to a unique S3 bucket name.
- Set `stack_name` to the desired CloudFormation stack name.
- Deploy with Terraform to create resources in the correct order.

### CloudFormation

- Use the generated S3 URL of the Datadog integration template to launch the stack.
- Provide Datadog keys and optionally customize deployment parameters.

***

## Outputs

| Output Name           | Description                           |
|----------------------|-------------------------------------|
| `stack_id`           | The CloudFormation stack ID          |
| `IAMRoleName`        | The name of the IAM role created for Datadog AWS Integration |
| `AccountId`          | AWS Account ID where stack is deployed|
| `Region`             | AWS Region where stack is deployed   |
| `DatadogForwarderArn` | Lambda ARN for the Datadog Forwarder (if installed) |

***

## Notes

- Ensure that the Datadog API and APP keys are kept confidential and are passed securely.
- The Lambda Log Forwarder helps in sending Lambda logs to Datadog; disable if you prefer to customize manually.
- Disabling metric or resource collection reduces AWS monitoring visibility in Datadog.
- Enable Cloud Security Posture Management to leverage Datadog's automated security checks.

***

## References

- Datadog AWS Integration Documentation and setup guide: Use the official Datadog documentation for deeper integration and troubleshooting.
- AWS CloudFormation and Terraform documentation for more information on resource management and module usage.

***

This setup provides a scalable and automated way to deploy Datadog monitoring and security integration for your AWS account using Terraform and CloudFormation.

---

<div align="center">

### Built by

**Durrell Gemuh** - Founder @ NextGen Playground | DevOps & Cloud Infrastructure Engineer | AWS Community Builder

[![Portfolio](https://img.shields.io/badge/Portfolio-durrellgemuh.com-000?style=flat-square&logo=vercel)](https://durrellgemuh.com)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-durrello-0A66C2?style=flat-square&logo=linkedin)](https://www.linkedin.com/in/durrello/)
[![Dev.to](https://img.shields.io/badge/Dev.to-durrello-0A0A0A?style=flat-square&logo=devdotto)](https://dev.to/durrello)
[![X](https://img.shields.io/badge/X-@durrelloo-000?style=flat-square&logo=x)](https://x.com/durrelloo)
[![GitHub](https://img.shields.io/badge/GitHub-durrello-181717?style=flat-square&logo=github)](https://github.com/durrello)
[![Email](https://img.shields.io/badge/Email-durrell.gemuh.a@gmail.com-EA4335?style=flat-square&logo=gmail)](mailto:durrell.gemuh.a@gmail.com)

---

⭐ **Star this repo** if you found it useful - it helps others discover it!

</div>

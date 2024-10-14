## One-time Setup: Initializing the Remote State Backend

This step is required to initialize the S3/DynamoDB backend for storing the 
Terraform state files and locks. This is a one-time setup and should be done
before running any other Terraform commands.

```bash
cd terraform/live/aws/ops-terraform-core-automation/us-east-2/terragrunt_s3_backend
terragrunt init
terragrunt apply
```

## AWS Nuke: Destroying All Resources in ops-opex-terraform-core-automation

This step purges all AWS objects created as part of the Terragrunt state stored
in AWS S3 and DynamoDB. This is a destructive operation and should be used with
caution.

```bash
cd terraform/scripts/aws-nuke
aws-nuke --config aws-nuke-config.yml --profile ops-opex-terraform-core-automation
```

## Directory Structure

This folder contains the live Terragrunt configurations for my Home Lab.  It i
organized in a hierarchy of folders that correspond to the Infrastructure
Provider, Account, Region and Environment.  The folder structure is as follows:

```text
live/
  aws/
    account/
      region/
        environment/
          subcomponent/
            terragrunt.hcl
          environment.hcl
        region.hcl
      account.hcl
    provider.hcl
  global.hcl
  terragrunt.hcl
```


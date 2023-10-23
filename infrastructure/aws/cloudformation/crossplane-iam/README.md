# Template for IAM Requiremewnts for Crossplane

## Purpose

This stack template creates IAM roles and policies that allow Crossplane to
provision resources in the AWS account.  It also creates an IAM user that
Crossplane will use to authenticate to the AWS API.

## How to Deploy this Template

### Via the Console

1. Authenticate to https://console.jumpcloud.com/userconsole
2. Click the AWS icon
3. Click Sign In.
4. Navigate to https://us-east-2.console.aws.amazon.com/cloudformation/home?region=us-east-2#/stacks/create
5. Copy and paste the following Amazon S3 URL `https://s3.us-east-2.amazonaws.com/cf-templates-40ajksj53ztb-us-east-2/2023-10-23T045256.866Zwmp-iam.yaml`
6. Click Next.
7. Choose a Stack name.  Example: `crossplane-iam`
8. Click Next.
9. Add any relevant cost reporting tags.
10. Click Next.
11. Review the configuration.
12. Acknowledge that CloudFormation might create IAM resources.
13. Click Submit.

### Via the AWS CLI

```bash
export AWS_PROFILE=ryezone-labs
export AWS_REGION=us-east-2
export STACK_NAME=crossplane-iam

aws cloudformation create-stack \
  --stack-name ${STACK_NAME} \
  --template-url https://s3.us-east-2.amazonaws.com/cf-templates-40ajksj53ztb-us-east-2/2023-10-23T044437.854Zlv1-iam.yaml \
```

## References

- [Cloudformation - AWS::IAM::ManagedPolicy](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-iam-managedpolicy.html)
- [Cloudformation - AWS::IAM::User](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-iam-user.html)
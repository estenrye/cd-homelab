# Template for Shared Amazon ECR repositories with all Operations OU accounts using AWS Organizations

## Purpose

This stack template creates Amazon ECR private repositories that allow EKS
clusters within any selected accounts of a selected OU of our Amazon Organization to
pull images from the repository.

## How to Deploy this Template

### Via the Console

1. Authenticate to https://console.jumpcloud.com/userconsole
2. Click the AWS icon
3. Select the `PF9-Administrator` or `PF9-Developer` role on the `platform9 (514845858982)` account.
4. Click Sign In.
5. Navigate to https://us-west-1.console.aws.amazon.com/cloudformation/home?region=us-west-1#/stacks/create
6. Copy and paste the following Amazon S3 URL `https://s3.us-west-1.amazonaws.com/cf-templates-11pv4e9hakmqf-us-west-1/2023-10-21T062639.507Z88f-registry.yaml`
7. Click Next.
8. Choose a Stack name.  Example: `registry-<your-repo-name>`
9. Choose a RepositoryName.
10. Click Next.
11. Add any relevant cost reporting tags.
12. Click Next.
13. Review the configuration.
14. Click Submit.


## How to manually push images to the registry

```bash
# If you have not previously used saml2aws with the platform9 account,
# you must first configure a profile.

export SAML2AWS_USERNAME=youremail@platform9.com
export SAML2AWS_ROLE=arn:aws:iam::514845858982:role/PF9-Administrator
# export SAML2AWS_ROLE=arn:aws:iam::514845858982:role/PF9-Developer
saml2aws configure \
  --idp-account=default \
  --profile=platform9 \
  --idp-provider=JumpCloud \
  --mfa=DUO \
  --url=https://sso.jumpcloud.com/saml2/aws

saml2aws login --profile platform9 --skip-prompt

export REPO_NAME=your-repo-name
aws ecr get-login-password --region us-west-1 --profile platform9 | docker login --username AWS --password-stdin 514845858982.dkr.ecr.us-west-1.amazonaws.com/${REPO_NAME}

docker build \
  --platform=linux/amd64 \
  -t 514845858982.dkr.ecr.us-west-1.amazonaws.com/${REPO_NAME}:0.0.1 \
  docker/kustomize-env

docker push 514845858982.dkr.ecr.us-west-1.amazonaws.com/${REPO_NAME}:0.0.1
```
## References

- [Sharing Amazon ECR repositories with multiple accounts using AWS Organizations](https://aws.amazon.com/blogs/containers/sharing-amazon-ecr-repositories-with-multiple-accounts-using-aws-organizations/)
- [Github: aws-samples/amazon-ecr-orgpath-sample](https://github.com/aws-samples/amazon-ecr-orgpath-sample/tree/main)
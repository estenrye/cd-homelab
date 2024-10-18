#!/bin/sh
set -e

if [ -z "$1" ]; then
  echo "TG_PATH positional arg is not set. Exiting."
  exit 1
fi

TG_PATH=`echo $1 | sed 's|live/||'`

if [ -z "$TG_AWS_PROFILE" ]; then
  echo "TG_AWS_PROFILE is not set. Exiting."
  exit 1
fi

if [ -z "TG_S3_BUCKET_URI" ]; then
  echo "TG_S3_BUCKET_URI is not set. Exiting."
  exit 1
fi
echo '{"LockID": { "S": "'${TG_DYNAMODB_TABLE}'/'${TG_PATH}'/terraform.tfstate-md5"}}'
echo "Purging state for ${TG_S3_BUCKET_URI}/${TG_PATH}/terraform.tfstate"
aws --profile ${TG_AWS_PROFILE} s3 rm ${TG_S3_BUCKET_URI}/${TG_PATH}/terraform.tfstate
aws --profile ${TG_AWS_PROFILE} dynamodb delete-item \
  --table-name "${TG_DYNAMODB_TABLE}" \
  --key='{"LockID": { "S": "'${TG_DYNAMODB_TABLE}'/'${TG_PATH}'/terraform.tfstate-md5"}}'

"${TG_DYNAMODB_TABLE}/${TG_PATH}/terraform.tfstate-md5"
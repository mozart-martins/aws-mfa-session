#!/bin/bash

MFA_ARN="arn:aws:iam::278519325336:mfa/resource-name"

SOURCE_PROFILE="cli-user-configured-using-aws-configure"
TARGET_PROFILE="cli-user-mfa"

read -p "MFA Token: " TOKEN

CRED=$(aws sts get-session-token \
  --serial-number "$MFA_ARN" \
  --token-code "$TOKEN" \
  --profile "$SOURCE_PROFILE" \
  --output json)

AWS_ACCESS_KEY_ID=$(echo "$CRED" | jq -r '.Credentials.AccessKeyId')
AWS_SECRET_ACCESS_KEY=$(echo "$CRED" | jq -r '.Credentials.SecretAccessKey')
AWS_SESSION_TOKEN=$(echo "$CRED" | jq -r '.Credentials.SessionToken')

aws configure set aws_access_key_id "$AWS_ACCESS_KEY_ID" --profile "$TARGET_PROFILE"
aws configure set aws_secret_access_key "$AWS_SECRET_ACCESS_KEY" --profile "$TARGET_PROFILE"
aws configure set aws_session_token "$AWS_SESSION_TOKEN" --profile "$TARGET_PROFILE"

echo "MFA created at profile [$TARGET_PROFILE]"
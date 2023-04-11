#!/bin/usr/env bash

# Set variables
IAM_USER="your-iam-user-name"

# Get list of all access keys
ALL_ACCESS_KEYS=$(aws iam list-access-keys --user-name "$IAM_USER" --query 'AccessKeyMetadata[*].AccessKeyId' --output text)

# Delete all access keys except current one
for ACCESS_KEY in $ALL_ACCESS_KEYS; do
  if [ "$ACCESS_KEY" != "$" ]; then
    aws iam delete-access-key --access-key-id "$ACCESS_KEY" --user-name "$IAM_USER"
  fi
done

# Create new access keys
NEW_ACCESS_KEYS=$(aws iam create-access-key --user-name "$IAM_USER")

# Update AWS CLI configuration
aws configure set aws_access_key_id "$(echo "$NEW_ACCESS_KEYS" | jq -r '.AccessKey.AccessKeyId')"
aws configure set aws_secret_access_key "$(echo "$NEW_ACCESS_KEYS" | jq -r '.AccessKey.SecretAccessKey')"

# Store new access keys in GitHub Actions secret store
echo "::set-secret name=$ACCESS_KEY_ID_SECRET_NAME::$(echo "$NEW_ACCESS_KEYS" | jq -r '.AccessKey.AccessKeyId')"
echo "::set-secret name=$SECRET_ACCESS_KEY_SECRET_NAME::$(echo "$NEW_ACCESS_KEYS" | jq -r '.AccessKey.SecretAccessKey')"
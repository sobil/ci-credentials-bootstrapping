#!/bin/usr/env bash

export AWS_SECRET_ACCESS_KEY=AKIAJDHP4PNIJX7BJBNQ
export AWS_ACCESS_KEY_ID=RL1bFF9copQvBV6ZA456KuIAX4SPT49rn53StwNe
export AWS_DEFAULT_REGION=ap-southeast-2


export BUCKET_NAME&&BUCKET_NAME="mywebsitebucket-$(date +%s)"

# create bucket
aws s3 create-bucket --bucket "$BUCKET_NAME" --region ap-southeast-2
# sync dirtectory
aws s3 sync . "s3://$BUCKET_NAME" --region ap-southeast-2

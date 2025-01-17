#!/usr/bin/bash


AWS_SECRET_KEY_ID=$1
AWS_SECRET_ACCESS_KEY=$2
EC2_INSTANCE_ID=$3
AWS_REGION=$4


sudo apt install awscli -y
aws --profile default configure set aws_access_key_id "$AWS_SECRET_KEY_ID"
aws --profile default configure set aws_secret_access_key "$AWS_SECRET_ACCESS_KEY"
aws --profile default configure set region "$AWS_REGION"



instance_status=$(aws ec2 describe-instance-status --instance-ids "$EC2_INSTANCE_ID" | grep -c "failed")

if [ "$instance_status" -ne 0 ]; then
  echo "Instance not in good shape, restarting ..."
  aws ec2 reboot-instances --instance-ids "$EC2_INSTANCE_ID"
else
  echo "Instance is in good shape, nothing to do here!"
fi



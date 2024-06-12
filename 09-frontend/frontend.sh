#!/bin/bash
dnf install ansible -y
pip3.9 install botocore boto3
ansible-pull -i localhost, -U https://github.com/daws-78s/expense-ansible-roles-tf.git main.yaml -e component=$component -e env=$environment
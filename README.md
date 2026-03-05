# aws-mfa-session

Simple bash script that retrieves temporary credentials from AWS STS using MFA and configures them in the AWS CLI profile.

## Requirements

### AWS CLI

Install the AWS CLI on Linux:

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

Verify installation:

aws --version

### jq

Install jq (Ubuntu/Debian):

sudo apt install jq

## Usage

1. Edit the script and set your MFA ARN:

MFA_ARN="arn:aws:iam::123456789012:mfa/cli-user"

2. Run the script:

./aws-mfa-session.sh

3. Enter the MFA code when prompted.

The script will request a temporary session token from AWS STS and configure it in your AWS CLI profile.

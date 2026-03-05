# aws-mfa-session

Simple Bash script that retrieves temporary credentials from AWS STS using MFA and configures them in an AWS CLI profile.

This script requests a temporary session token from AWS Security Token Service (STS) and updates the configured AWS CLI profile with the temporary credentials.

---

## Requirements

### AWS CLI

Install the AWS CLI on Linux:

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

unzip awscliv2.zip

sudo ./aws/install

Verify installation:

aws --version

---

### jq

The script uses `jq` to parse the JSON returned by AWS STS.

Install on Ubuntu/Debian:

sudo apt install jq

---

## IAM Policy (Optional but Recommended)

This repository includes an example IAM policy that requires MFA for most AWS CLI operations.

Policy file location:

iam/require-mfa-policy.json

When this policy is attached to an IAM user, most AWS CLI commands will be denied unless MFA is used.

In that scenario:

- Direct AWS CLI commands will fail
- The user must first obtain temporary credentials using MFA
- This script simplifies that process

---

## How It Works

Typical workflow when the MFA policy is attached:

AWS CLI command → Access denied (MFA required)  
Run this script → MFA code requested  
Temporary credentials issued by AWS STS  
AWS CLI commands work using temporary credentials

---

## Usage

### 1. Configure AWS CLI

Configure your AWS credentials:

aws configure --profile cli-user

You will be prompted to enter:

- AWS Access Key ID
- AWS Secret Access Key
- Default region
- Output format

---

### 2. Configure the MFA ARN

Edit the script and set your MFA device ARN:

MFA_ARN="arn:aws:iam::123456789012:mfa/cli-user"

---

### 3. Run the script

./aws-mfa-session.sh

Enter the MFA code when prompted.

The script will:

1. Request a temporary session token from AWS STS
2. Extract the temporary credentials
3. Configure them in your AWS CLI profile

---

## Repository Structure

aws-mfa-session

├── aws-mfa-session.sh  
├── README.md  
└── iam  
  └── require-mfa-policy.json
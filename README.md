# How to execute and deploy terraform

## Using AWS CLI
The recommended way, following good practices, is to use the AWS CLI logged into AWS, and then run terraform

# Step-by-Step Guide: AWS IAM Setup, AWS CLI, and Terraform

## Step 1: Create an IAM User in AWS

1. Access the [AWS Management Console](https://aws.amazon.com/).
2. Log in with your administrator credentials or a user with permissions to create IAM users.
3. In the navigation pane, go to "IAM" (Identity and Access Management).

### Create a User:

[AWS IAM Documentation](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_access-keys.html)

4. In the IAM navigation pane, click "Users."
5. Click "Add user" and follow the instructions to set up the user.
6. In the "Permissions" section, you can note permissions directly for the user.
7. Note the username and the generated access credentials (Access Key and Secret Access Key).

## Step 2: Configure AWS CLI using `aws configure`

Now that you have an IAM user, you can set up the AWS CLI to authenticate to your AWS account.

1. Open your terminal or command prompt.

2. Run the `aws configure` command and follow the instructions:

   - **AWS Access Key ID**: Enter the access key generated for the IAM user.
   - **AWS Secret Access Key**: Enter the secret access key generated for the IAM user.
   - **Default region name**: Enter the AWS region you want to use (example., `sa-east-1`).
   - **Default output format**: You can leave this blank or choose an output format (example., `json`).

After configuring the AWS CLI, you are ready to use Terraform.


This document outlines the step-by-step process for configuring your Terraform environment to manage infrastructure using remote state stored in an AWS S3 bucket.

## Prerequisites

1. Ensure that Terraform is installed on your local machine.

## Step 1: Create S3 Bucket for Remote State

Navigate to the `/bucket` directory in your project and perform the following steps:

1. Open a terminal in the `/bucket` directory.

2. Initialize the Terraform configuration:

   ```shell
   terraform init
   ```
3. Apply the Terraform configuration to create the S3 bucket:
   ```shell
   terraform apply
   ```
This will create the S3 bucket that will be used to store the remote state.

# Step 2: Configure Terraform in the Root Directory

This step explains how to configure Terraform in the root directory of your project.

## Procedure

1. Open a terminal in the root directory of your project.

2. Initialize the Terraform configuration by running the following command:

   ```shell
   terraform init
   ```
3. Apply the Terraform configuration to provision your infrastructure:
   ```shell
   terraform apply
   ```
This configuration will use the S3 bucket created in Step 1 for storing remote state. All Terraform state will be securely stored remotely in this bucket.


**Accessing Database Passwords**

This section explains how to access the passwords for your database resources.

## Procedure

1. Log in to the AWS Management Console.

2. Navigate to the S3 section.

3. Locate and select the S3 bucket that was created in Step 1.

4. Within the bucket, find the remote state file.

5. Open the remote state file and search for the password associated with your database resource. The password will be encrypted and stored within the AWS environment.

By following these steps, you will be able to securely manage your infrastructure using Terraform and access the necessary credentials for your database resources.

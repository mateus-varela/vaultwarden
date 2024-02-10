# How to execute and deploy terraform

## Using AWS CLI
The recommended way, following good practices, is to use the AWS CLI logged into AWS, and then run terraform.
Take care with the profile used to execute your code.

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

Just be aware to which profile you will be using during your deploy. You can check the profile accessing ~/.aws/credentials through AWS CLI.

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


# Accessing Database Passwords with AWS Secrets Manager

This guide explains how to access the passwords for your database resources using AWS Secrets Manager.

## Procedure

1. Log in to the [AWS Management Console](https://console.aws.amazon.com/).

2. Search "Secrets Manager" in the search bar and open it.

3. On the AWS Secrets Manager homepage, you'll find a list of created secrets. Select the secret that corresponds to the database for which you want to access the password.

4. On the secret's details page, you'll find the database password. Open the secret and to display, you may need to retrieve it. Click in retrieve it.

5. Now that you have the database password, you can use it as needed to access the database from your application or for any other authorized purpose.

Make sure to keep these passwords secure and ensure that only authorized individuals have access to them.

For more information about AWS Secrets Manager, refer to the [official AWS documentation](https://aws.amazon.com/secrets-manager/).

## Working with tfvars Files

`tfvars` files are used to set input variables for your Terraform configurations. These variables provide customization and flexibility in your infrastructure provisioning.

In your project, you can use a `terraform.tfvars` file to define key input variables:

```bash
eks_cluster_name = "eks name"
vpc_cidr = "cidr block"

cidrs = {
    private = [" cidr blocks "]
    public  = [" cidr blocks "]
}

region = "region"
vpc_name = "name"
```

These variables can be used in your Terraform configurations and will override any default values specified in the `variables.tf` files from the root.

You can add more variables in the .tfvars file, since they are consumed by some of the `.tf` files in root module. If you want to change some variable that is inside `/_modules/folder` you will need to change the `variables.tf` file of the module. Ex: if you want to change variable "environment" of your RDS, you will need to change inside `/_modules/rds/variables.tf` since variable `environment` is consumed only from RDS module. 

By using `tfvars`, you can keep your configurations dynamic and easily adaptable to different environments.


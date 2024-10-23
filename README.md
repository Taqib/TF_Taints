Terraform Taints
This lab is designed to give you hands-on experience with the terraform taint and terraform untaint commands. By the end of this lab, you will be able to identify and manage tainted resources.

Understanding Tainted Resources
Terraform taints mark a resource for recreation in the next terraform apply operation. This can happen automatically if Terraform fails to provision a resource, marking it as "tainted" due to the failure. Tainted resources are then scheduled for destruction and recreation to fix any issues.

You can also manually taint a resource using the terraform taint command, forcing it to be recreated in the next apply. If you decide that a resource shouldn't be recreated, you can reverse the tainted status with the terraform untaint command, preventing it from being destroyed and recreated.

Prerequisites
configure AWS using aws configure command in the AWS CLI.
Create a VPC in the AWS ap-southeast-1 region.
Create a subnet in the VPC and copy the subnet ID.
Automatic Tainting due to Provisioner Failure
Scenario Overview
You will simulate a scenario where an EC2 instance's creation fails due to an incorrect local provisioner configuration, resulting in Terraform automatically marking the resource as tainted.

Step 1: Create the Terraform Configuration
Create a new directory for this lab and navigate into it.

Create a main.tf file with the following content:
This configuration attempts to create an EC2 instance and store its public IP in a file. The path /invalid_path/ is intentionally incorrect.

Step 2: Initialize and Apply the Configuration
Initialize Terraform in your directory:

terraform init
Apply the configuration:

terraform apply
Observe the failure caused by the incorrect file path.

Step 3: Inspect the Tainted Resource
After the failure, run:

terraform plan
Notice that Terraform marks the aws_instance.web_server resource as tainted and plans to recreate it.

Step 4: Correct the Configuration and Apply
Correct the file path in main.tf:

command = "echo ${self.public_ip} > /tmp/web_server_ip.txt"
Apply the changes:

terraform apply
Verify that the instance is recreated successfully, and the file is written to the correct path.

Manually Tainting and Untainting Resources
Scenario Overview
In this scenario, you will manually taint a resource to force its recreation and then untaint it to prevent unnecessary recreation.

Steps
Step 1: Create a New Terraform Configuration
Modify your main.tf to remove the provisioner and just create an EC2 instance:

Step 2: Init and Apply the Configuration
Init the terraform:

terraform init
Apply the changes:

terraform apply
Verify that the instance is created successfully.

Step 3: Manually Taint the Resource
Use the terraform taint command to mark the instance as tainted:

terraform taint aws_instance.web_server

Run the command:

terraform plan
to see that Terraform plans to recreate the instance.

Step 4: Untaint the Resource
Use the terraform untaint command to remove the taint:

terraform untaint aws_instance.web_server

Run the command:

terraform plan
This will confirm that the instance will not be recreated.

Step 5: Apply the Final Configuration
Apply the final configuration:

terraform apply
Verify that no changes are made to the existing instance.

Summary

In this lab, you practiced handling tainted resources in Terraform, both automatically and manually. These skills are essential for managing infrastructure as code, ensuring that resources are provisioned correctly.
# Building a (super) simple 3-tier web app on AWS

A simple 3-tier web app that log user's information (name, log in time) when he/she logs in

To automate creation and management of this app, I use Terraform. Terraform is a Infrastructure as Code (IaC) tool that allow us to  manage infrastructure with configuration files rather than through a graphical user interface (AWS Console, for example)

## Architect

In this project, I use Terraform to create following components on AWS:

- AWS VPC(Virtual Private Cloud)  
- VPC Subnet inside the VPC in which I run this app
- Internet Gateway to connect to the Internet from inside of VPC
- DynamoDb table where I save the log in data of users
- EC2 instance where I run the web app
- Instance profile with appropriate policy to use DynamoDB service 

Simple diagram of the architect (Thanks to drawio):



![Diagram](./Terraform/AWS-web-Terraform.png)

## How to test?

You must have Terraform CLI already set up on your computer. To create the all the components, move to Terraform folder and run this single command:

```
terraform apply
```

When all components are created, you can go to AWS EC2 service console to check the public IP Adress of newly created instance that run the app

From then, go to ```http://<ip-address>:3000/users``` from your browser to access the app

When you've done, to avoid unexpected charges, use the following command to delete all the resources:

```
terraform destroy
```

# TechChallengeApp

## Architecture 
![Alt text](./architecture.jpeg?raw=true "architecture")

## Prerequisites
* Install terraform ( preferrably 14.5, as this has been tested on 14.5). 
* Install aws cli
* Configure aws credentials using command below.
```
  aws configure
```
* Download the repository

## Create private S3 bucket for remote tfstate storage
**Note:** You can skip this step if you dont want remote backend. Remove /terraform/backend.tf as well in that case
* Change directory to /terraform/backend
* Change any variable values in /terraform/backend/backendenv.tfvars if needed
* Change any values in /terraform/backend/main.tf if needed
* Run below commands to create S3 bucket
```
  terraform init
  terraform plan -out plan.out -var-file="backendenv.tfvars"
  terraform apply "plan.out
```


## Create infra using terraform
* Change directory to /terraform directory
* Create a ssh key pair using the command below.
```
  ssh-keygen
```
* Save the private key which will be later use to access vms. Copy the contents of the public key and update in /terraform/env.tfvrs.
* Edit the env.tfvars file to update the missing values. The variables are self*explainatory

* Run below commands from /terraform directory
```
  terraform init
  terraform plan -out plan.out -var-file="env.tfvars"
  terraform apply "plan.out"
```
* The above commands will setup below components
```
-vpc
-subnet_a
-subnet_b
-launch configuration
-postgres rds in ha mode with no public acces and using a subnet group of subnet_a and subnet_b
-auto scaling group with 2 vms with docker installed the app running on docker on port 8080. vms are allowed to be accessed from specific ip addresses. 
-security groups with necessary access.
-application load balancer pointing to asg with periodic healthchecks, inturn triggering scale up of instances in asg in case of faliure.
```

## Access the application from the allowed ip address
* You will get the load balancer url when the script completes its run.
* Or you can get the application load balancer address from the portal or using the command below.
```
terraform output -json lb_url
```
* Use the above address to access the app from the browser.


## Comments
* DNS has not been setup in this configuration to access the app/alb

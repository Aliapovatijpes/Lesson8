# Lesson 8

#### Terraform
##### These scripts were developped with Terraform v1.2.6 on windows_amd64; provider registry.terraform.io/hashicorp/aws v4.25.0. 
Before using these scripts, you must install and configure Terraform and aws provider. Download scripts to your computer. Next step is to add your credentials to vars.tf file. Make it with renaming ars.tf.example file. Also you must change password for MySQL in "userdata.sh" file. Now you can start terraforming with cli:
##### terraform apply
##### After applying, please wait a few minutes to full app deployment. Now you can assign domain name to obtained ip adress and use an app, or use it over ip adress.

# Lesson 8

#### Terraform
##### These scripts were developped with Terraform v1.2.6 on windows_amd64; provider registry.terraform.io/hashicorp/aws v4.25.0. 
Before using these scripts, you must install and configure Terraform and aws provider. Download scripts to your computer. Next step is to change domain name to yours at row, which you can find with "traefik.http.routers.phpmyadmin.rule=Host" in user_data.sh file. Now you can start terraforming with cli:
##### terraform apply
##### After applying, please wait a few minutes to full app deployment. Now you must assign domain name to obtained ip adress, than you can use an app.

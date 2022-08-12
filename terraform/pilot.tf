provider "aws" {
    region                  = var.region
    shared_credentials_file = "~/.aws/credentials"
    profile                 = "terraform-assignment"
}

####################################################################################
####                                                                            ####
####  Please Note:                                                              ####
####  Terraform backend doesn't allow interpolations that is why following      ####
####  variables are hard-coded. To setup the infra in a completely new/separate ####
####  account, the developer would have to make a S3 Bucket manually and pass   ####
####  the bucket name in the following configuration.                           ####
####                                                                            ####
####################################################################################

terraform {
    backend "local" {
        path                    = "terraform.tfstate"
    } 
}
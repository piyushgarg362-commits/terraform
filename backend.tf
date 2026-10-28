terraform {
required_version = ">= 1.10.0"
backend "s3" {
bucket = "piyush-terraform-state-2026-unique123"
key = "jenkins-terraform-aws/dev/terraform.tfstate"
region = "us-east-2"
encrypt = true
use_lockfile = true
}
}

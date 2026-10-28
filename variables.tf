variable "aws_region" {
description = "AWS region for the project"
type = string
default = "us-east-2"
}
variable "project_name" {
description = "Project name used in resource tags"
type = string
default = "jenkins-project"
}
variable "instance_type" {
description = "EC2 instance type"
type = string
default = "t3.micro"
}
variable "ssh_allowed_cidr" {
description = "Approved IPv4 CIDR for SSH, e.g. your public IP/32"
type = string
validation {
condition = can(cidrnetmask(var.ssh_allowed_cidr))
error_message = "Provide a valid IPv4 CIDR, preferably your public IP with /32."
}
}

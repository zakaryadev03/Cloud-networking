variable "vpc_id" {
    description = "The ID of the VPC to attach to the Transit Gateway"
    type        = string
}

variable "subnet_id" {
    description = "The ID of the subnet in the VPC to attach to the Transit Gateway"
    type        = string
}

variable "project_name" {
    description = "The name of the project for tagging resources"
    type        = string
}
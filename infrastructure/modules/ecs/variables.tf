variable "cluster_name" {}
variable "alb_name" {}
variable "vpc_id" {}
variable "public_subnet_ids" {
type = list(string)
}
variable "container_image" {
description = "ECR image URI"
type = string
}
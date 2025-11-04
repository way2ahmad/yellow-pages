variable "region" {
type = string
default = "us-east-1"
}


variable "vpc_cidr" {
type = string
default = "10.0.0.0/16"
}


variable "public_subnet_cidrs" {
type = list(string)
default = ["10.0.1.0/24", "10.0.2.0/24"]
}


variable "db_username" {
type = string
default = "admin"
}


variable "db_password" {
type = string
sensitive = true
default = "changeme123"
}
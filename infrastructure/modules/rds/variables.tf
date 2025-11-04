variable "db_name" {}
variable "db_username" {}
variable "db_password" {
sensitive = true
}
variable "subnet_ids" {
type = list(string)
}
variable "vpc_security_group_ids" {
type = list(string)
}
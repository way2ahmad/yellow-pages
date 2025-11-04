resource "aws_vpc" "main" {
cidr_block = var.vpc_cidr
}


resource "aws_subnet" "public" {
count = length(var.public_subnet_cidrs)
vpc_id = aws_vpc.main.id
cidr_block = var.public_subnet_cidrs[count.index]
map_public_ip_on_launch = true
}


resource "aws_internet_gateway" "igw" {
vpc_id = aws_vpc.main.id
}
resource "aws_vpc" "new-vpc" {
    cidr_block = "10.1.0.0/16"
    tags = {
        Name = "${var.prefix}-vpc"
    }
}


####
# Codigo usado antes da refatoração
####
# resource "aws_subnet" "new-subnet-1" {
#     availability_zone = "us-east-1a"
#     vpc_id = aws_vpc.new-vpc.id
#     cidr_block = "10.1.0.0/24"
#     tags = {
#         Name = "${var.prefix}-subnet-1"
#     }
# }
# resource "aws_subnet" "new-subnet-2" {
#     availability_zone = "us-east-1b"
#     vpc_id = aws_vpc.new-vpc.id
#     cidr_block = "10.1.1.0/24"
#     tags = {
#         Name = "${var.prefix}-subnet-2"
#     }
# }

# Retorna as zonas de disponibilidade 
data "aws_availability_zones" "az" {}

resource "aws_subnet" "subnets" {
    count = 2
    availability_zone = data.aws_availability_zones.az.names[count.index]
    vpc_id = aws_vpc.new-vpc.id
    cidr_block = "10.1.${count.index}.0/24"
    map_public_ip_on_launch = true
    tags = {
        Name = "${var.prefix}-subnet-${count.index}"
    }
}

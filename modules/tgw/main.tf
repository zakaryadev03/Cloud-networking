terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }
}


resource "aws_ec2_transit_gateway" "tgw" {
  description = "${var.project_name} Transit Gateway"

  auto_accept_shared_attachments = "disable"
  default_route_table_association = "enable"
  default_route_table_propagation = "enable"

  tags = {
    Name = "${var.project_name}-tgw"
  }
}

resource "aws_ec2_transit_gateway_vpc_attachment" "tgw" {
  transit_gateway_id = aws_ec2_transit_gateway.tgw.id
  vpc_id             = var.vpc_id
  subnet_ids         = [var.subnet_id]

  tags = {
    Name = "${var.project_name}-tgw-attachment"
  }
}



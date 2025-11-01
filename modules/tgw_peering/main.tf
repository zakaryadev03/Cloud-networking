terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }
}

resource "aws_ec2_transit_gateway_peering_attachment" "main" {
  transit_gateway_id      = var.tgw_id
  peer_transit_gateway_id = var.peer_tgw_id
  peer_region             = var.peer_region

  tags = {
    Name = "${var.project_name}-tgw-peering"
  }
}

output "peering_id" {
  value = aws_ec2_transit_gateway_peering_attachment.main.id
}

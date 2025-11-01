module "vpc_ireland" {
  source = "./modules/vpc"

  providers = {
    aws = aws.ireland
  }

  project_name        = "ireland-${var.project_name}"
  vpc_cidr_block      = "10.0.0.0/16"
  subnet_cidr_block   = "10.0.1.0/24"
  availability_zone   = "eu-west-1a"
}

module "vpc_frankfurt" {
  source = "./modules/vpc"

  providers = {
    aws = aws.frankfurt
  }

  project_name        = "frankfurt-${var.project_name}"
  vpc_cidr_block      = "10.1.0.0/16"
  subnet_cidr_block   = "10.1.1.0/24"
  availability_zone   = "eu-central-1a"
}

module "tgw_ireland" {
  source        = "./modules/tgw"
  providers     = { aws = aws.ireland }
  project_name  = "ireland-${var.project_name}"
  vpc_id        = module.vpc_ireland.vpc_id
  subnet_id     = module.vpc_ireland.public_subnet_id
}

module "tgw_frankfurt" {
  source        = "./modules/tgw"
  providers     = { aws = aws.frankfurt }
  project_name  = "frankfurt-${var.project_name}"
  vpc_id        = module.vpc_frankfurt.vpc_id
  subnet_id     = module.vpc_frankfurt.public_subnet_id
}

module "tgw_peering" {
  source           = "./modules/tgw_peering"
  providers        = { aws = aws.ireland }
  project_name     = "${var.project_name}ireland-frankfurt"
  tgw_id           = module.tgw_ireland.tgw_id
  peer_tgw_id      = module.tgw_frankfurt.tgw_id
  peer_region      = "eu-central-1"
}

resource "aws_ec2_transit_gateway_peering_attachment_accepter" "frankfurt" {
  provider                     = aws.frankfurt
  transit_gateway_attachment_id = module.tgw_peering.peering_id

  tags = {
    Name = "frankfurt-accept-peering"
  }
}

# Ireland Route Table
resource "aws_route" "ireland_to_frankfurt" {
  route_table_id         = module.vpc_ireland.route_table_id
  destination_cidr_block = "10.1.0.0/16"  # Frankfurt VPC CIDR
  transit_gateway_id     = module.tgw_ireland.tgw_id
}

# Frankfurt Route Table
resource "aws_route" "frankfurt_to_ireland" {
  provider               = aws.frankfurt
  route_table_id         = module.vpc_frankfurt.route_table_id
  destination_cidr_block = "10.0.0.0/16"  # Ireland VPC CIDR
  transit_gateway_id     = module.tgw_frankfurt.tgw_id
}

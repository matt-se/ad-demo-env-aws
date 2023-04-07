
###### AWS

resource "aws_vpc" "vpc" {
  cidr_block = var.aws_vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = {
    Name = "${var.environment_name}-vpc"
  }
}

data "aws_arn" "main" {
  arn = aws_vpc.vpc.arn
}


resource "aws_subnet" "foo" {
  vpc_id            = aws_vpc.main.id
  availability_zone = "us-east-1a"
  cidr_block        = "172.31.0.0/24"
}

resource "aws_subnet" "bar" {
  vpc_id            = aws_vpc.main.id
  availability_zone = "us-east-1b"
  cidr_block        = "172.31.1.0/24"
}


resource "aws_vpc_peering_connection_accepter" "main" {
  vpc_peering_connection_id = hcp_aws_network_peering.example.provider_peering_id
  auto_accept               = true
}


####### HCP

resource "hcp_hvn" "hvn" {
  hvn_id = "${var.environment_name}-hvn"
  cloud_provider = "aws"
  region = "us-east-1"
  cidr_block = var.hcp_hvn_cidr
}




// Create a network peering between the HVN and the AWS VPC
resource "hcp_aws_network_peering" "example" {
  hvn_id          = hcp_hvn.hvn.hvn_id
  peering_id      = "${var.environment_name}-peering"
  peer_vpc_id     = aws_vpc.vpc.id
  peer_account_id = aws_vpc.vpc.owner_id
  peer_vpc_region = data.aws_arn.main.region
}

// Create an HVN route that targets your HCP network peering and matches your AWS VPC's CIDR block
resource "hcp_hvn_route" "example" {
  hvn_link         = hcp_hvn.hvn.self_link
  hvn_route_id     = "${var.environment_name}-hvn-route"
  destination_cidr = aws_vpc.vpc.cidr_block
  target_link      = hcp_aws_network_peering.example.self_link
}

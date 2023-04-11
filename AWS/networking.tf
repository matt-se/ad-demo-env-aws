
###### AWS
resource "aws_vpc" "vpc" {
  cidr_block = var.aws_vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = {
    Name = "${var.environment_name}-vpc"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "igw_${var.environment_name}"
  }
}

data "aws_arn" "main" {
  arn = aws_vpc.vpc.arn
}

resource "aws_subnet" "foo" {
  vpc_id            = aws_vpc.vpc.id
  availability_zone = "us-east-1a"
  cidr_block        = "172.31.0.0/24"
}


// create a security group allowing all incoming and outgoing traffic on every port
resource "aws_security_group" "sg_all" {
  name        = "sg_all_${var.environment_name}"
  description = "Allow all traffic"
  vpc_id      = aws_vpc.vpc.id
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}



resource "aws_vpc_peering_connection_accepter" "main" {
  vpc_peering_connection_id = hcp_aws_network_peering.example.provider_peering_id
  auto_accept               = true
}

resource "aws_route_table" "rtb_public" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.environment_name}_rtb_public"
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}


resource "aws_route_table_association" "rta_subnet_public" {
  subnet_id      = aws_subnet.foo.id
  route_table_id = aws_route_table.rtb_public.id
}



####### HCP
resource "hcp_hvn" "hvn" {
  hvn_id = "hvn-${var.environment_name}"
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

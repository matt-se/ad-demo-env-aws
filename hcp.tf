resource hcp_hvn hvn {
  hvn_id = "ad-demo-env-aws"
  cloud_provider = "aws"
  region = "us-east-1"
  cidr_block = var.hcp_hvn_cidr
  tags = {
    Name = "ad-demo-env-aws"
  }
}
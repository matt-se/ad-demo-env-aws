resource "aws_directory_service_directory" "ad" {
  name     = var.ad_name
  password = var.ad_password
  edition  = "Standard"
  type     = "MicrosoftAD"

  vpc_settings {
    vpc_id     = aws_vpc.vpc.id
    subnet_ids = [aws_subnet.foo.id, aws_subnet.bar.id]
  }

  tags = {
    Project = "${var.environment_name}-ad"
  }
}


/*
resource "ad_ou" "o" { 
    name = "top-org"
    path = "dc=corp,dc=notexample,dc=com"
    description = "OU for tests"
    protected = false
}

resource "ad_ou" "groupz" {
  name        = "groupz"
  path        = ad_ou.o.path
  description = ad_ou.o.description
  protected   = false
}
*/









output "ad_dns_ip" {
  value = aws_directory_service_directory.ad.dns_ip_addresses
}

output "ad_id" {
  value = aws_directory_service_directory.ad.id
}

output "ad_name" {
  value = aws_directory_service_directory.ad.name
}

output "ad_sg" {
  value = aws_directory_service_directory.ad.security_group_id
}

output "ad_url" {
  value = aws_directory_service_directory.ad.access_url
}




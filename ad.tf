resource "aws_directory_service_directory" "ad" {
  name     = "corp.notexample.com"
  password = "SuperSecretPassw0rd"
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
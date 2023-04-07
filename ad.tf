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

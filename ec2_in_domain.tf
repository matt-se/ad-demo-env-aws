# Get latest Windows Server 2022 AMI
data "aws_ami" "windows-2022" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["Windows_Server-2022-English-Full-Base*"]
  }
}

resource "aws_key_pair" "key_for_windows_server" {
  key_name   = "win_server_${var.environment_name}_keypair"
  public_key = var.windows_public_key
}


resource "aws_instance" "windows" {
  ami           = data.aws_ami.windows-2022.id
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.bar.id
  key_name = aws_key_pair.key_for_windows_server.key_name
  vpc_security_group_ids      = [aws_security_group.sg_all.id]
  associate_public_ip_address = true

  tags = {
    Name = "windows_${var.environment_name}"
    owner = var.owner
    version = var.app_version
  }
  
  user_data = <<EOF
<powershell>
Add-Computer -DomainName '${var.ad_domain_name}' -NewName 'instance_to_configure_ad' -Credential (New-Object -TypeName PSCredential -ArgumentList '${var.ad_admin_name}',(ConvertTo-SecureString -String '${var.ad_admin_password}' -AsPlainText -Force)[0]) -Restart
</powershell>
EOF


  connection {
      type        = "winrm"
      #user        = var.windows_key_user
      private_key = var.windows_private_key
      host        = self.public_ip
    }
}
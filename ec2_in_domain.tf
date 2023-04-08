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
# Install the necessary AD DS role and management tools
Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools

# Set up the domain and configure the AD Forest
$domainName = "${var.ad_domain_name}}"
$netBIOSName = "${var.ad_netBIOS_name}"
$safeModePassword = "${var.ad_admin_password}"

# Convert the Safe Mode password to a Secure String
$secureSafeModePassword = ConvertTo-SecureString $safeModePassword -AsPlainText -Force

# Install the new Forest with the specified domain name and Safe Mode password
Install-ADDSForest `
  -CreateDnsDelegation:$false `
  -DatabasePath "C:\Windows\NTDS" `
  -DomainMode "Win2012R2" `
  -DomainName $domainName `
  -DomainNetbiosName $netBIOSName `
  -ForestMode "Win2012R2" `
  -InstallDns:$true `
  -LogPath "C:\Windows\NTDS" `
  -NoRebootOnCompletion:$false `
  -SysvolPath "C:\Windows\SYSVOL" `
  -Force:$true `
  -SafeModeAdministratorPassword $secureSafeModePassword

# The server will reboot automatically once the installation process is complete

</powershell>
EOF


  connection {
      type        = "winrm"
      #user        = var.windows_key_user
      private_key = var.windows_private_key
      host        = self.public_ip
    }
}
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
  subnet_id     = aws_subnet.foo.id
  key_name = aws_key_pair.key_for_windows_server.key_name
  vpc_security_group_ids      = [aws_security_group.sg_all.id]
  associate_public_ip_address = true
  get_password_data     =   "true"
  tags = {
    Name = "windows_${var.environment_name}"
    owner = var.owner
    version = var.app_version
  }
 
  /*
  connection {
      type        = "winrm"
      user        = var.ad_admin_username
      password    = rsadecrypt(self.password_data,file("dales-dead-bug_frontend_windows_dev_keypair.pem"))
      host        = self.public_ip
      https       = true
      insecure    = true
      timeout     = "10m"
      agent      = false
    } */
  user_data_replace_on_change = true
  user_data = "${file("installAD.txt")}"
}


output "windows_public_ip" {
  value = aws_instance.windows.public_ip
}
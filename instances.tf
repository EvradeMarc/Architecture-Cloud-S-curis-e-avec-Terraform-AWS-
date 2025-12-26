# Bastion
resource "aws_instance" "bastion" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.client.id
  key_name      = var.key_name
  security_groups = [aws_security_group.bastion_sg.id]

  tags = { Name = "Bastion-SSH" }
}

# HAProxy
resource "aws_instance" "haproxy" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.client.id
  key_name      = var.key_name
  security_groups = [aws_security_group.haproxy_sg.id]

  user_data = file("haproxy.sh")

  tags = { Name = "HAProxy" }
}

# Serveurs internes
resource "aws_instance" "web" {
  count         = 2
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.server.id
  key_name      = var.key_name
  security_groups = [aws_security_group.server_sg.id]

  user_data = file("web.sh")

  tags = {
    Name = "Web-${count.index + 1}"
  }
}

# FTP
resource "aws_instance" "ftp" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.server.id
  key_name      = var.key_name
  security_groups = [aws_security_group.server_sg.id]

  user_data = file("ftp.sh")

  tags = { Name = "FTP" }
}


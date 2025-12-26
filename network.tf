resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
}

# Subnet Client (public)
resource "aws_subnet" "client" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  map_public_ip_on_launch = true
}

# Subnet Serveur (privé)
resource "aws_subnet" "server" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"
}

# Table de routage publique
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "client_assoc" {
  subnet_id      = aws_subnet.client.id
  route_table_id = aws_route_table.public.id
}

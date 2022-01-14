resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "k8sDemo-kubernetes0004"
	Project = "UKI Kubernetes Workshop instance: kubernetes0004"
  }
}

resource "aws_default_security_group" "default" {
  vpc_id = aws_vpc.main.id

  ingress {
    protocol  = -1
    self      = true
    from_port = 0
    to_port   = 0
  }

  tags = {
    Name = "k8sDemo-kubernetes0004"
	Project = "UKI Kubernetes Workshop instance: kubernetes0004"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.0.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "k8sDemo-kubernetes0004"
	Project = "UKI Kubernetes Workshop instance: kubernetes0004"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "k8sDemo-kubernetes0004"
	Project = "UKI Kubernetes Workshop instance: kubernetes0004"
  }
}

resource "aws_main_route_table_association" "a" {
  vpc_id         = aws_vpc.main.id
  route_table_id = aws_route_table.rt.id
}


resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }


  tags = {
    Name = "k8sDemo-kubernetes0004"
	Project = "UKI Kubernetes Workshop instance: kubernetes0004"
  }
}


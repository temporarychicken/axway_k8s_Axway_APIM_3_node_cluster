# Fetch k8s base Centos 8 Machine and North South Router AMI identifiers

data "aws_ami" "k8s-base-machine" {
  most_recent = true
  owners      = ["self"]
  filter {
    name = "tag:Name"
    values = [
      "kubernetes0004.k8s-base-machine",
    ]
  }
}

# Locate the correct zone from Route53

data "aws_route53_zone" "selected" {
  name         = "axwaydemo.net"
  private_zone = false
}

data "local_file" "foo" {
    filename = "k8s-key.pem"
}
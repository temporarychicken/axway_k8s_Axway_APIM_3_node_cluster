resource "aws_key_pair" "controller-kubernetes0004" {
  key_name   = "k8s-server-key-kubernetes0004"
  public_key = file ("~/.ssh/k8s-key.pub")
}

resource "aws_key_pair" "north-south-router-kubernetes0004" {
  key_name   = "north-south-router-key-kubernetes0004"
  public_key = file ("~/.ssh/north-south-router-key.pub")
}
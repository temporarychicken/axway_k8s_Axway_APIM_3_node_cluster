# Set some defaults for AWS like region.
#provider "aws" {
# profile = "default"
# region  = "eu-west-2"
#}



resource "aws_route53_record" "apimanager-kubernetes0004" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = "apimanager.kubernetes0004.${data.aws_route53_zone.selected.name}"
  type    = "A"
  ttl     = "60"
  records = [ aws_instance.kubernetes0004-k8s-master.public_ip ]

}

resource "aws_route53_record" "apigateway-kubernetes0004" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = "apigateway.kubernetes0004.${data.aws_route53_zone.selected.name}"
  type    = "A"
  ttl     = "60"
  records = [ aws_instance.kubernetes0004-k8s-master.public_ip ]

}

resource "aws_route53_record" "api-kubernetes0004" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = "api.kubernetes0004.${data.aws_route53_zone.selected.name}"
  type    = "A"
  ttl     = "60"
  records = [ aws_instance.kubernetes0004-k8s-master.public_ip ]

}




resource "aws_route53_record" "dockerregistry-kubernetes0004" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = "dockerregistry.kubernetes0004.${data.aws_route53_zone.selected.name}"
  type    = "A"
  ttl     = "60"
# records = ["${chomp(http.myip.body)}"]
  records = [ aws_instance.kubernetes0004-docker-registry.public_ip ]

}

resource "aws_route53_record" "kubernetes-kubernetes0004" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = "kubernetes.kubernetes0004.${data.aws_route53_zone.selected.name}"
  type    = "A"
  ttl     = "60"
# records = ["${chomp(http.myip.body)}"]
#  records = [ aws_instance.kubernetes0004-nginx-plus-gateway-1.public_ip ]
  records = [ aws_instance.kubernetes0004-k8s-master.public_ip ]

}

resource "aws_route53_record" "k8s-master-kubernetes0004" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = "k8s-master.kubernetes0004.${data.aws_route53_zone.selected.name}"
  type    = "A"
  ttl     = "60"
# records = ["${chomp(http.myip.body)}"]
  records = [ aws_instance.kubernetes0004-k8s-master.public_ip ]

}

resource "aws_route53_record" "worker-node-1-kubernetes0004" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = "worker-node-1.kubernetes0004.${data.aws_route53_zone.selected.name}"
  type    = "A"
  ttl     = "60"
# records = ["${chomp(http.myip.body)}"]
  records = [ aws_instance.kubernetes0004-worker-node-1.public_ip ]

}


resource "aws_route53_record" "worker-node-2-kubernetes0004" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = "worker-node-2.kubernetes0004.${data.aws_route53_zone.selected.name}"
  type    = "A"
  ttl     = "60"
# records = ["${chomp(http.myip.body)}"]
  records = [ aws_instance.kubernetes0004-worker-node-2.public_ip ]

}

resource "aws_route53_record" "k8sdashboard-kubernetes0004" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = "k8sdashboard.kubernetes0004.${data.aws_route53_zone.selected.name}"
  type    = "A"
  ttl     = "60"
# records = ["${chomp(http.myip.body)}"]
  records = [ aws_instance.kubernetes0004-k8s-master.public_ip ]

}

resource "aws_route53_record" "ingressdashboard-kubernetes0004" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = "ingressdashboard.kubernetes0004.${data.aws_route53_zone.selected.name}"
  type    = "A"
  ttl     = "60"
# records = ["${chomp(http.myip.body)}"]
  records = [ aws_instance.kubernetes0004-k8s-master.public_ip ]

}

resource "aws_route53_record" "cafe-kubernetes0004" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = "cafe.kubernetes0004.${data.aws_route53_zone.selected.name}"
  type    = "A"
  ttl     = "60"
# records = ["${chomp(http.myip.body)}"]
#  records = [ aws_instance.kubernetes0004-nginx-plus-gateway-1.public_ip ]
  records = [ aws_instance.kubernetes0004-k8s-master.public_ip ]

}

resource "aws_route53_record" "cafe2-kubernetes0004" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = "cafe2.kubernetes0004.${data.aws_route53_zone.selected.name}"
  type    = "A"
  ttl     = "60"
# records = ["${chomp(http.myip.body)}"]
#  records = [ aws_instance.kubernetes0004-nginx-plus-gateway-1.public_ip ]
  records = [ aws_instance.kubernetes0004-k8s-master.public_ip ]

}
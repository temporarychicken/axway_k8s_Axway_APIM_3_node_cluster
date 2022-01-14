resource "aws_instance" "kubernetes0004-k8s-master" {
  ami                         = data.aws_ami.k8s-base-machine.id # eu-west-2
  instance_type               = "t2.medium"
  key_name                    = "k8s-server-key-kubernetes0004"
  associate_public_ip_address = true
  security_groups             = [aws_security_group.nginx-web-facing.id]
  subnet_id                   = aws_subnet.main.id
  private_ip                  = "10.0.0.30"

 
  provisioner "remote-exec" {
  
    connection {
    type     = "ssh"
    user     = "centos"
	private_key = file("~/.ssh/k8s-key.pem")
    host     = self.public_ip
  }
  
        inline = [
  	    "./bash_scripts/install-kubernetes-master.sh",
		"./bash_scripts/install_nfs_server.sh",
		"#./bash_scripts/install_nginx_ingress_controller.sh",
		"kubectl patch storageclass my-nfs -p '{\"metadata\": {\"annotations\":{\"storageclass.kubernetes.io/is-default-class\":\"true\"}}}'",
        "#./bash_scripts/install_APIM.sh"
    ]
  }

  
  volume_tags = {
	Project = "UKI Kubernetes Workshop instance: kubernetes0004"	
  }

  tags = {
    Name = "kubernetes0004-k8s-master"
	Project = "UKI Kubernetes Workshop instance: kubernetes0004"
  }
}


resource "null_resource" "displayk8stoken" {
  triggers = {
    first_trigger  = null_resource.buildimages.id
  }



  provisioner "remote-exec" {
  
    connection {
    type     = "ssh"
    user     = "centos"
	private_key = file("../2_packer/keys/k8s-key.pem")
    host     = aws_instance.kubernetes0004-k8s-master.public_ip
  }
  
        inline = [
		"#sleep 30s",
		"sudo systemctl restart nginx",
		"./bash_scripts/install_APIM.sh | true",
		"#cd Cloud-Automation;helm upgrade axwayapimplatform APIM/amplify-apim-7.7-1.3.0.tgz --reuse-values --set dynamicLicense=true",
		"echo 'Here is your access token for logging into the Kubernetes Dashboard at https://k8s-master.kubernetes0004.axwaydemo.net:32443'",
		"kubectl -n kubernetes-dashboard describe secret $(kubectl -n kubernetes-dashboard get secret | grep admin-user | awk '{print $1}')"

    ]
  }
  



  provisioner "local-exec" {
  
        command = "echo 'To log into your k8s-master node via ssh and access the kubectl command, together with scripts to install APIM and ISTIO, use:';echo 'ssh-keygen -R k8s-master.kubernetes0004.axwaydemo.net';echo 'ssh -i ~/.ssh/k8s-key.pem centos@k8s-master.kubernetes0004.axwaydemo.net'"
  
  }		
  
  
}



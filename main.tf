variable "aws_access_key" {}
variable "aws_secret_key" {}

provider "aws" {
  region = "us-east-1"
  #Store credential keys in a variables file ie. terraform.tfvars
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

resource "aws_instance" "jenkins_server" {
  ami = "ami-08c40ec9ead489470"
  instance_type = "t2.micro"
  
  key_name = "master_key"
  #Security Group Open Ports: (22, 80, and 8080)
  vpc_security_group_ids = ["sg-061b45b708f19a354"]
  #Installs Jenkins and its dependencies
  user_data = "${file("jenkins_install.sh")}"

  tags = {
    "Name" : "jenkins_terra_server"
  }
  
}

output "instance_ip" {
  value = aws_instance.jenkins_server.public_ip
  
}
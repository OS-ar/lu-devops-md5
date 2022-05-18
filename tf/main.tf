provider "aws" {
  region = var.region
}
# resource "aws_key_pair" "ao-tf-pub" {
#   key_name   = "ao_key_pair"
#   public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK0MJ2IZSmowimybBxhjK9o3e7dbDfnjbgkoWacyL1+L"
# }
resource "aws_instance" "ansible-hosts" {
  # Creates four identical aws ec2 instances
  count = "2"     
  ami = var.ami_id
  instance_type = var.inst_type
  key_name = "ao_key_pair"
  # Create ansible user 
  user_data = "${file("cloud_init.sh")}" 
  tags = {
    # The count.index allows you to launch a resource 
    # starting with the distinct index number 0 and corresponding to this instance.
    Name = "grp2-ao-ansible-host-${count.index}"
  }
}
resource "aws_instance" "ansible-master" {
      
  # All instances will have the same ami and instance_type
  ami = var.ami_id
  instance_type = var.inst_type
  key_name = "ao_key_pair"
  user_data = <<EOF
#!/bin/bash 
sudo apt update
sudo apt install software-properties-common
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install ansible
hostnamectl set-hostname master-arturs-os
EOF 
  tags = {
    # The count.index allows you to launch a resource 
    # starting with the distinct index number 0 and corresponding to this instance.
    Name = "grp2-ao-ansible-master"
    }
}
provider "aws" {
  region = var.region
}
resource "aws_key_pair" "ao-tf-pub" {
  key_name   = "aws_key"
  public_key = "${file("aws_key.pub")}"
}
resource "aws_instance" "ansible-hosts" {
  # Creates four identical aws ec2 instances
  count = 2     
  
  ami = var.inst_type
  instance_type = var.instance_type
  key_name = aws_key_pair.ao-tf-pub
  # Create ansible user 
  user_data = "${file("cloud_init.sh")}" 
  tags = {
    # The count.index allows you to launch a resource 
    # starting with the distinct index number 0 and corresponding to this instance.
    Name = "ansible-host-${count.index}"
  }
}
resource "aws_instance" "ansible-master" {
      
  # All instances will have the same ami and instance_type
  ami = var.inst_type
  instance_type = var.instance_type 
  key_name = aws_key_pair.ao-tf-pub 
  tags = {
    # The count.index allows you to launch a resource 
    # starting with the distinct index number 0 and corresponding to this instance.
    Name = "ansible-host-${count.index}"
  }
}
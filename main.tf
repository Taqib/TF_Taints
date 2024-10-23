provider "aws" {
  region = "ap-southeast-1"
}

resource "aws_instance" "web_server" {
  ami           = "ami-060e277c0d4cce553"  # This should be a valid AMI for your region.
  instance_type = "t2.micro"
  subnet_id     = "subnet-00f1b75bcf63872f9" 

  provisioner "local-exec" {
    command = "echo ${self.public_ip} > /invalid_path/web_server_ip.txt"
  }
}

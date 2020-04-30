provider "aws" {
  profile = "default"
  region  = "ap-south-1"
}

resource "aws_instance" "EC2_Instance" {
  ami                  = "ami-0b1641a17487c041f"
  instance_type        = "t2.micro"
  key_name             = "EC2 Key"
  iam_instance_profile = "s3-admin-access"
  tags = {
    Name = "WebServer"
  }
  connection  {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("C:\\Users\\ajagdale\\Documents\\EC2 Key")
    host        = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo yum install httpd -y",
      "sudo aws s3 cp s3://s3-aniruddha/index.html /var/www/html/",
      "sudo service httpd start",
      "sudo chkconfig httpd on"
    ]
  }
}





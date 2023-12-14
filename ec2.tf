resource "aws_instance" "web" {
  ami           = "ami-0416c18e75bd69567"
  instance_type = "t3.medium"

  tags = {
    Name = "HelloWorld"
  }
}

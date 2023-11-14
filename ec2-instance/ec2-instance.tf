provider "aws" {
  region = "us-east-1"
  profile = "default"
}

// https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance

// ami-01eccbf80522b562b Amazon Linux 2 AMI (HVM) - Kernel 5.10, SSD Volume Type

#Create EC2 instance
resource "aws_instance" "instance-example" {
  ami                    = "ami-example"
  instance_type          = "t3.micro"
  subnet_id = "subnet-example"
  vpc_security_group_ids = ["sg-example"]
  iam_instance_profile = "role-ssm"
  key_name               = "key-example"
  user_data = <<EOF
          #!/bin/bash
          cd /tmp
          sudo yum install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm
          sudo systemctl enable amazon-ssm-agent
          sudo systemctl start amazon-ssm-agent
        EOF
  tags = {
    Name = "instance-example"
    Environment = "Dev"
    Provider = "Provider example"
    Schedule = "True"
    Stop = "MON-FRI-0000"
    Start = "MON-FRI-0100"
    Backup = "MON-FRI-0800"
  }
}

#Create an Elastic IP
resource "aws_eip" "eip-example" {
  domain = "vpc"
}


#Associate EIP with EC2 Instance
resource "aws_eip_association" "eip-example-association" {
  instance_id   = aws_instance.instance-example.id
  allocation_id = aws_eip.eip-example.id
}
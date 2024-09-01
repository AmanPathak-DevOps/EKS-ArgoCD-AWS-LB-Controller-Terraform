resource "aws_instance" "ec2" {
  ami = data.aws_ami.ami.id
  instance_type = "t2.micro"
  availability_zone = "us-east-2a"
  iam_instance_profile = aws_iam_instance_profile.ec2-instance-profile.id
  subnet_id = aws_subnet.public-subnet[0].id
  vpc_security_group_ids = [aws_security_group.ec2-sg.id]

  root_block_device {
    volume_size = 30
  }

  tags = {
    Name = "eks-server-deploy"
  }

  user_data = <<-EOF
  #!/bin/bash
  sudo apt install unzip -y
  sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
  wget -O- https://apt.releases.hashicorp.com/gpg | \
  gpg --dearmor | \
  sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null
  gpg --no-default-keyring \
  --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
  --fingerprint
  echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
  https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
  sudo tee /etc/apt/sources.list.d/hashicorp.list
  sudo apt update
  sudo apt-get install terraform -y
  curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
  unzip awscliv2.zip
  sudo ./aws/install
  curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
  curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
  sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
EOF
}
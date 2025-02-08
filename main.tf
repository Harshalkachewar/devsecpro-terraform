resource "aws_security_group" "Jenkins-project2-sg" {
  name        = "Jenkins-Security Group"
  description = "Open 22,443,80,8080,9000,8081,9090,9100"

  # Define individual ingress rules with specific descriptions
  ingress = [
    {
      description      = "SSH"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
    },
    {
      description      = "HTTP"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
    },
    {
      description      = "HTTPS"
      from_port        = 443
      to_port          = 443
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
    },
    {
      description      = "Jenkins"
      from_port        = 8080
      to_port          = 8080
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
    },
    {
      description      = "SonarQube"
      from_port        = 9000
      to_port          = 9000
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
    },
    {
      description      = "Grafana"
      from_port        = 3000
      to_port          = 3000
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
    },
    {
      description      = "docker-portfrd"
      from_port        = 8081
      to_port          = 8081
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
    },
    {
      description      = "Prometheus"
      from_port        = 9090
      to_port          = 9090
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
    },
    {
      description      = "Node Exporter"
      from_port        = 9100
      to_port          = 9100
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
    }
  ]

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Jenkins-project2-sg"
  }
}

resource "aws_instance" "web" {
  ami                    = "ami-04b4f1a9cf54c11d0"
  instance_type          = "t2.large"
  key_name               = "terra-key"
  vpc_security_group_ids = [aws_security_group.Jenkins-project2-sg.id]
  user_data              = templatefile("./install_scripts.sh", {})

  tags = {
    Name = "Jenkins-project"
  }
  root_block_device {
    volume_size = 30
  }
}

resource "aws_eip" "my_eip" {
  domain = "vpc"

  tags = {
    Name = "MyElasticIP"
  }
}

resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.web.id
  allocation_id = aws_eip.my_eip.id
}

resource "aws_security_group" "Jenkins-project2-sg" {
  name        = "Jenkins-Security Group"
  description = "Open 22,443,80,8080,9000,8081"

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

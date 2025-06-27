#Security Groups for the Proxy Cluster Bridge and Workers
#------------------------------------------
resource "aws_security_group" "bridge" {
  name_prefix = "sdm-proxy-"

  vpc_id = module.vpc.vpc_id

  ingress {
    description     = "Allow TCP:8443 from NLB"
    from_port       = 8443
    to_port         = 8443
    security_groups = [aws_security_group.nlb.id]
    protocol        = "tcp"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }
}
resource "aws_security_group" "worker" {
  name_prefix = "sdm-proxy-"

  vpc_id = module.vpc.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }
}
#-----------------------------------------------

#Security Group for the Network Load Balancer
#------------------------------------------------
resource "aws_security_group" "nlb" {
  name_prefix = "sdm-proxy-"

  vpc_id = module.vpc.vpc_id

  ingress {
    description = "Allow TCP:443 ingress"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.ingress_cidr_blocks
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }
}
#-------------------------------------------------



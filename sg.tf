# security groups that allows only ws netwokr and internal network
resource "aws_security_group" "allow_redis" {
  name                    = "roboshop-${var.ENV}-redis-sg"
  description             = "roboshop-${var.ENV}-redis-sg"
  vpc_id                  = data.terraform_remote_state.vpc.outputs.VPC_ID


  ingress {
    from_port       = var.REDIS_PORT
    to_port         = var.REDIS_PORT
    protocol        = "tcp"
    cidr_blocks     = [data.terraform_remote_state.vpc.outputs.VPC_CIDR, data.terraform_remote_state.vpc.outputs.DEFAULT_VPC_CIDR]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags = {
    Name = "roboshop-${var.ENV}-redis-sg"
  }
}
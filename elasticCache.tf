# Provisions Elastic-Cache Cluster 
resource "aws_elasticache_cluster" "redis" {
  cluster_id           = "roboshop-${var.ENV}-redis"
  engine               = "redis"
  node_type            = "cache.t3.small"
  num_cache_nodes      = 1
  parameter_group_name = aws_elasticache_parameter_group.redis_pg.name
  engine_version       = "6.x"
  port                 = 6379
  subnet_group_name    = aws_elasticache_subnet_group.redis.name 
  security_group_ids   = [aws_security_group.allow_redis.id]
}

# Elastic-Cache Parameter Group 
resource "aws_elasticache_parameter_group" "redis_pg" {
  name                 = "roboshop-${var.ENV}-redis-pq"
  family               = "redis6.x"
}

# Creates a Subnet Group For the Groups-Of-Subnets 
resource "aws_elasticache_subnet_group" "redis" {
  name                 = "roboshop-${var.ENV}-redis-subnetgroup"
  subnet_ids           = data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNET_IDS
}
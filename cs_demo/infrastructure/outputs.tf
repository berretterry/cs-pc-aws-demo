output "vpc_id" {
  value = module.vpc.vpc_id
}

output "vpc_cidr_block" {
  value = module.vpc.vpc_cidr_block
}

output "private_subnet_ids" {
  value = module.vpc.private_subnets
}

output "public_subnet_ids" {
  value = module.vpc.public_subnets
}

output "ecs_cluster_name" {
  value = aws_ecs_cluster.this.name
}

output "worker_security_group_id" {
  value       = aws_security_group.worker.id
  description = "The ID of the security group which proxy workers are assigned to"
}
output "bridge_security_group_id" {
  value       = aws_security_group.bridge.id
  description = "The ID of the security group which proxy bridges are assigned to"
}

output "worker_role_arn" {
  value       = aws_iam_role.this_task.arn
  description = "IAM Role ARN of the workers"
}
output "nlb_address" {
  value       = aws_lb.this.dns_name
  description = "The ID of the security group which proxy bridges are assigned to"
}
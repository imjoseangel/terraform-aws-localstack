output "ids" {
  description = "List of IDs of instances"
  value       = module.ec2.id
}

output "vpc_security_group_ids" {
  description = "List of VPC security group ids assigned to the instances"
  value       = module.ec2.vpc_security_group_ids
}

output "tags" {
  description = "List of tags"
  value       = module.ec2.tags
}

output "instance_id" {
  description = "EC2 instance ID"
  value       = module.ec2.id[0]
}

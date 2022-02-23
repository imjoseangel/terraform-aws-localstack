output "ids" {
  description = "List of IDs of instances"
  value       = module.ec2.id
}

output "tags" {
  description = "List of tags"
  value       = module.ec2.tags_all
}

output "instance_id" {
  description = "EC2 instance ID"
  value       = module.ec2.id[0]
}

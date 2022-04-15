output "tags" {
  description = "List of tags"
  value       = aws_instance.main.tags_all
}

output "instance_id" {
  description = "EC2 instance ID"
  value       = aws_instance.main.id
}

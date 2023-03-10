output "openstack_public_ips" {
  value       = aws_instance.openstack[*].public_ip
  description = "IP of the public instance"
}

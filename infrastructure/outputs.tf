output "openstack_public_ips" {
  value       = aws_instance.openstack[*].public_ip
  description = "IP of the public instance"
}

output "openstack_private_ips" {
  value       = aws_instance.openstack[*].private_ip
  description = "Private IPs of the OpenStack instance"
}

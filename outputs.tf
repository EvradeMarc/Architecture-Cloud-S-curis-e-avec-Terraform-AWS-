output "bastion_ip" {
  value = aws_instance.bastion.public_ip
}

output "haproxy_ip" {
  value = aws_instance.haproxy.public_ip
}

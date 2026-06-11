output "alb_dns_name" {
  value = aws_lb.app.dns_name
}

output "app_sg_id" {
  value = aws_security_group.app.id
}

output "bastion_public_ip" {
  value = aws_instance.bastion.public_ip
}

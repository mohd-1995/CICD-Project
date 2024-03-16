resource "aws_route53_zone" "domain" {
  name = "moesportfolio.com"
}



output "lb_dns_name" {
  description = "The DNS name of the load balancer"
  value       = aws_lb.lb.dns_name
}


output "auto_scaling_group_name" {
  value = aws_autoscaling_group.web.name
}
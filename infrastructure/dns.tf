resource "aws_route53_zone" "domain" {
  name = "moesportfolio.com"
}



#output name 
output "lb_dns_name" {
  description = "The DNS name of the load balancer"
  value = aws_lb.lb.dns_name
}
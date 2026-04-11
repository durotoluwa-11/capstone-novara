resource "aws_route53_zone" "main" {
  name = var.domain_name

  tags = {
    Name        = var.domain_name
    cluster     = var.cluster_name
  }
}

resource "aws_route53_record" "cluster_ns" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "taskapp.${var.domain_name}"
  type    = "NS"
  ttl     = "30"

  records = aws_route53_zone.main.name_servers
}

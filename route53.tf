resource "aws_route53_zone" "zone" {

  name = var.domain_name

}


resource "aws_route53_record" "load_balancer" {

  zone_id = aws_route53_zone.zone.zone_id
  name    = var.domain_name
  type    = "A"

  alias {
    name                   = aws_lb.app_lb.dns_name
    zone_id                = aws_lb.app_lb.zone_id
    evaluate_target_health = true
  }

}


resource "aws_route53_record" "cert_validation_dns" {

  allow_overwrite = true
  name            = tolist(aws_acm_certificate.cert.domain_validation_options)[0].resource_record_name
  records         = [tolist(aws_acm_certificate.cert.domain_validation_options)[0].resource_record_value]
  type            = tolist(aws_acm_certificate.cert.domain_validation_options)[0].resource_record_type
  zone_id         = aws_route53_zone.zone.zone_id
  ttl             = 60

}


resource "aws_acm_certificate" "cert" {

  domain_name       = var.domain_name
  validation_method = "DNS"

}


resource "aws_acm_certificate_validation" "cert_validation" {

  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = ["${aws_route53_record.cert_validation_dns.fqdn}"]

}
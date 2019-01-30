resource "aws_route53_record" "soul" {
  zone_id = "${data.aws_route53_zone.selected.zone_id}"
  name    = "${var.codcliente}${var.env}soul.${data.aws_route53_zone.selected.name}"
  type    = "CNAME"
  ttl     = "300"
  records = ["${data.aws_instance.soul.public_dns}"]
}

resource "aws_route53_record" "pep" {
  zone_id = "${data.aws_route53_zone.selected.zone_id}"
  name    = "${var.codcliente}${var.env}pep.${data.aws_route53_zone.selected.name}"
  type    = "CNAME"
  ttl     = "300"
  records = ["${data.aws_instance.pep.public_dns}"]
}

resource "aws_route53_record" "windows" {
  zone_id = "${data.aws_route53_zone.selected.zone_id}"
  name    = "${var.codcliente}${var.env}windows.${data.aws_route53_zone.selected.name}"
  type    = "CNAME"
  ttl     = "300"
  records = ["${data.aws_instance.windows.public_dns}"]
}

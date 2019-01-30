resource "aws_security_group" "frontend" {
  name = "SG_${var.codcliente}"

  tags {
   Name = "${var.codcliente}_HTTP"
  }
  description = "HTTP AND RDS"
  vpc_id      = "${data.aws_vpc.selected.id}"


 ingress {
   from_port   = 80
   to_port     = 80
   protocol    = "TCP"
   cidr_blocks = ["xxx.xxx.xxx.xxx/32"]
 }


 ingress {
   from_port   = 1521
   to_port     = 1521
   protocol    = "TCP"
   cidr_blocks = ["${var.cidr1a}"]
 }

 ingress {
   from_port   = 1521
   to_port     = 1521
   protocol    = "TCP"
   cidr_blocks = ["${var.cidr1b}"]
 }

 ingress {
   from_port   = 1521
   to_port     = 1521
   protocol    = "TCP"
   cidr_blocks = ["${var.cidr1c}"]
 }

 egress {
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}
}

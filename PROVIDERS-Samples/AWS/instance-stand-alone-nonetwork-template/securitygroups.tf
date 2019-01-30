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
   cidr_blocks = ["189.39.119.66/32"]
 }


 ingress {
   from_port   = 1521
   to_port     = 1521
   protocol    = "TCP"
   cidr_blocks = ["${data.aws_subnet.new-1a.cidr_block}"]
 }

 ingress {
   from_port   = 1521
   to_port     = 1521
   protocol    = "TCP"
   cidr_blocks = ["${data.aws_subnet.new-1b.cidr_block}"]
 }

 ingress {
   from_port   = 1521
   to_port     = 1521
   protocol    = "TCP"
   cidr_blocks = ["${data.aws_subnet.new-1c.cidr_block}"]
 }

 egress {
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}
}

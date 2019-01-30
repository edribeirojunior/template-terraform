resource "aws_subnet" "new-1a" {
   vpc_id = "${data.aws_vpc.selected.id}"
   cidr_block = "${var.cidr1a}"
   availability_zone = "${var.AWS_REGION}"
   tags {
        Name = "${var.codcliente}-${var.iniciaiscliente}_1a"
        }
}

resource "aws_subnet" "new-1b" {
   vpc_id = "${data.aws_vpc.selected.id}"
   cidr_block = "${var.cidr1b}"
   availability_zone = "${var.AWS_REGION}"
   tags {
        Name = "${var.codcliente}-${var.iniciaiscliente}_1b"
        }
}

resource "aws_subnet" "new-1c" {
   vpc_id = "${data.aws_vpc.selected.id}"
   cidr_block = "${var.cidr1c}"
   availability_zone = "${var.AWS_REGION}"
   tags {
        Name = "${var.codcliente}-${var.iniciaiscliente}_1c"
        }
}

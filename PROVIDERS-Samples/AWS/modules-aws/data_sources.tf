data "aws_ami" "amazon" {
  most_recent   = true
 filter {
   name = "name"
   values = [
 	"amzn-ami-hvm-*-x86_64-gp2", 
   ]
 }

 filter {
  name = "owner-alias"
  values = [
	"amazon", 
  ]
}
}

data "aws_ami" "windows" {
  most_recent   = true

 filter {
   name = "name"
   values = ["Windows_Server-2012-R2_RTM-English-64Bit-Base-2018.09.15"]
 }

 filter {
  name = "platform"
  values = [
	"windows",
  ]
 }

 filter {
  name = "owner-alias"
  values = [
	"amazon",
  ]
 } 
}

data "aws_route53_zone" "selected" {
  name         = "${var.dns_name}"
  private_zone = false
}

data "aws_instance" "soul" {
  instance_tags {
    Name = "${var.codcliente}-${var.env}-APP-SOULMV-${var.envnumber}"
  }

  depends_on = ["aws_eip.ipsoul"]
}

data "aws_instance" "pep" {
  instance_tags {
    Name = "${var.codcliente}-${var.env}-APP-PEP-${var.envnumber}"
  }

  depends_on = ["aws_eip.ippep"]
}

data "aws_instance" "windows" {
  instance_tags {
    Name = "${var.codcliente}-${var.env}-APP-WINDOWS-${var.envnumber}"
  }

  depends_on = ["aws_eip.ipwindows"]
}

data "aws_vpc" "selected" {
  tags = {
    Name = "${var.Nome_VPC}"
  }
}

data "aws_security_group" "mvonly" {
  name = "MV_ONLY"
}

data "aws_security_group" "plantaomv" {
 name = "PlantaoMV"
}

resource "aws_key_pair" "key" {
  key_name = "key-${var.codcliente}"
  public_key = "${var.key_name}"
}

resource "aws_instance" "SOUL-Imagem" {
  ami           = "${data.aws_ami.amazon.id}"
  instance_type = "${var.instance_type_linux}"
  subnet_id     = "${data.aws_subnet.new-1a.id}"
  key_name      = "${aws_key_pair.key.key_name}"

  ebs_block_device = {
    volume_size           = 100
    device_name           = "/dev/xvda"
    volume_type           = "gp2"
    delete_on_termination = true
  }

  vpc_security_group_ids = ["${aws_security_group.frontend.id}", "${data.aws_security_group.mvonly.id}", "${data.aws_security_group.plantaomv.id}"]

  tags {
    Name     = "${var.codcliente}-${var.env}-APP-SOULMV-${var.envnumber}"
    Cliente  = "${var.codcliente}-${var.iniciaiscliente}"
    Shutdown = "${var.tag_shutdown}"
    Startup  = "${var.tag_startup}"
  }

  volume_tags {
    Name    = "${var.codcliente}-${var.env}-APP-SOULMV-${var.envnumber}-DISK"
    Cliente = "${var.codcliente}-${var.iniciaiscliente}"
  }

  user_data = <<HEREDOC
  #!/bin/bash
  sudo yum update -y
HEREDOC
}

resource "aws_instance" "PEP-Imagem" {
  ami           = "${data.aws_ami.amazon.id}"
  instance_type = "${var.instance_type_linux}"
  subnet_id     = "${data.aws_subnet.new-1a.id}"
  key_name      = "${aws_key_pair.key.key_name}"

  ebs_block_device = {
    volume_size           = 100
    device_name           = "/dev/xvda"
    volume_type           = "gp2"
    delete_on_termination = true
  }

  vpc_security_group_ids = ["${aws_security_group.frontend.id}", "${data.aws_security_group.mvonly.id}", "${data.aws_security_group.plantaomv.id}"]

  tags {
    Name     = "${var.codcliente}-${var.env}-APP-${var.envnumber}-PEP"
    Cliente  = "${var.codcliente}-${var.iniciaiscliente}"
    Shutdown = "${var.tag_shutdown}"
    Startup  = "${var.tag_startup}"
  }

  volume_tags {
    Name    = "${var.codcliente}-${var.env}-APP-PEP-${var.envnumber}-DISK"
    Cliente = "${var.codcliente}-${var.iniciaiscliente}"
  }

  user_data = <<HEREDOC
  #!/bin/bash
  sudo yum update -y
HEREDOC
}

resource "aws_instance" "WIN-Imagem" {
  ami           = "${data.aws_ami.windows.id}"
  instance_type = "${var.instance_type_windows}"
  subnet_id     = "${data.aws_subnet.new-1a.id}"
  key_name      = "${aws_key_pair.key.key_name}"

  ebs_block_device = {
    volume_size           = 100
    device_name           = "/dev/sda1"
    volume_type           = "gp2"
    delete_on_termination = true
  }

  vpc_security_group_ids = ["${aws_security_group.frontend.id}", "${data.aws_security_group.mvonly.id}", "${data.aws_security_group.plantaomv.id}"]

  tags {
    Name     = "${var.codcliente}-${var.env}-APP-WINDOWS-${var.envnumber}"
    Cliente  = "${var.codcliente}-${var.iniciaiscliente}"
    Shutdown = "${var.tag_shutdown}"
    Startup  = "${var.tag_startup}"
  }

  volume_tags {
    Name    = "${var.codcliente}-${var.env}-APP-WINDOWS-${var.envnumber}-DISK"
    Cliente = "${var.codcliente}-${var.iniciaiscliente}"
  }
}

resource "aws_eip" "ipsoul" {
  instance   = "${aws_instance.SOUL-Imagem.id}"
  depends_on = ["aws_instance.SOUL-Imagem"]
}

resource "aws_eip" "ippep" {
  instance   = "${aws_instance.PEP-Imagem.id}"
  depends_on = ["aws_instance.PEP-Imagem"]
}

resource "aws_eip" "ipwindows" {
  instance   = "${aws_instance.WIN-Imagem.id}"
  depends_on = ["aws_instance.WIN-Imagem"]
}

output "soul_addr" {
   value = "${aws_route53_record.soul.name}"
}
output "pep_addr" {
   value = "${aws_route53_record.pep.name}"
}
output "windows_addr" {
   value = "${aws_route53_record.windows.name}"
}

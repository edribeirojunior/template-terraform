provider "aws" {
  access_key = "${var.AWS_ACCESS}"
  secret_key = "${var.AWS_SECRET}"
  region     = "${var.AWS_REGION}"
}

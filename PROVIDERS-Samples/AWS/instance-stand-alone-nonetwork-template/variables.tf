variable "codcliente" {
  description = "Codigo do cliente(utilize o padrão 0)?"
}

variable "env" {
  description = "Ambiente(PRD/SML/TRN/CS1/CS2)? "
}

variable "iniciaiscliente" {
  description = "Iniciais do cliente?"
}

variable "envnumber" {
  description = "Numero do Ambiente (STRING)?"
}

variable "instance_type_linux" {
  description = "Check Instance Types in https://aws.amazon.com/pt/ec2/instance-types/"
}

variable "instance_type_windows" {
}

variable "key_name" {
 description = "Put as described here: https://www.terraform.io/docs/providers/aws/r/key_pair.html"
}

variable "tag_shutdown" {
  description = "Informar o valor da TAG SHUTDOWN"
}

variable "tag_startup" {
  description = "Informar o valor da TAG STARTUP"
}

variable "AWS_ACCESS" {
}

variable "AWS_SECRET" {
}

variable "AWS_REGION" {
  description = "Exemplos: Sao Paulo(sa-east-1), N.Virginia(us-east-1), N.California(us-west-1), Ohio(us-east-2)"
}

variable "dns_name" {
  description = "Colocar o dns requerido (Dominio deve existir no route 53!)"
}

variable "Nome_VPC" {
  description = "Nome da VPC? "
}

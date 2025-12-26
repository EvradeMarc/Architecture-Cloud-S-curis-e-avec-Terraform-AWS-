variable "aws_region" {
  default = "us-west-2"
}

variable "key_name" {
  description = "Nom de la clé SSH AWS"
}

variable "ami_id" {
  description = "AMI Amazon Linux"
  default     = "ami-0ebf411a80b6b22cb"
}

variable "instance_type" {
  default = "t2.micro"
}

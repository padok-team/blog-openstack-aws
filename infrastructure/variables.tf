variable "aws_region" {
  type = string
}

variable "ssh_public_key" {
  type = string
}

variable "openstack_cluster_size" {
  type    = number
  default = 1
}

variable "instance_type" {
  type    = string
  default = "t2.xlarge"
}

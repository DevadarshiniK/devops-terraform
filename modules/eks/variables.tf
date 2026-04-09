variable "cluster_name" {}
variable "vpc_id" {}
variable "private_subnets" {}

variable "tags" {
  type = map(string)
}
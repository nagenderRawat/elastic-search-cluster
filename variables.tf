variable "aws_access_key" {
  type = string
  description = "AWS access key"
}
variable "aws_secret_key" {
  type = string
  description = "AWS secret key"
}
variable "region" {
  type = string
  description = "AWS region"
  default = "us-east-2"
}

variable "instance_count" {
  type = number
  description = "node instance count"
  default = 3
}

variable "instance_type" {
  type = string
  description = "aws instance type"
  default = "t3.small.elasticsearch"
}

variable "dedicated_master_enabled" {
  type = bool
  description = "dedicated master enabled"
  default = false
}

variable "dedicated_master_count" {
  type = number
  description = "dedicated master count"
  default = 2
}

variable "dedicated_master_type" {
  type = string
  description = "dedicated master type"
  default = "t3.small.elasticsearch"
}

variable "ebs_enabled" {
  type = bool
  description = "enabled ebs?"
  default = true
}

variable "ebs_volume_size" {
  type = number
  description = "ebs volume size"
  default = 10
}

variable "encrypt_at_rest_enabled" {
  type = bool
  description = "encrypt at rest enabled"
  default = true
}







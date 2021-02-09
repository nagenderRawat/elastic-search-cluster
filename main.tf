# Terraform configuration to create an Elastic search cluster in aws.

# Specify the cloud provider.
provider "aws" {
  ## Cluster region
  region = var.region
  access_key = var.aws_access_key
  secret_key= var.aws_secret_key
}

resource "aws_vpc" "es-home-vpc" {
  cidr_block       = "10.0.0.0/28"
  enable_dns_hostnames = true

  tags = {
    Name = "es-home"
  }
}

resource "aws_subnet" "es-subnet1" {
  vpc_id     = aws_vpc.es-home-vpc.id
  cidr_block = "10.0.0.0/28"

  tags = {
    Name = "es-subnet1"
  }
}

resource "aws_iam_service_linked_role" "es" {
  aws_service_name = "es.amazonaws.com"
}

resource "aws_elasticsearch_domain" "es" {
  domain_name           = "es-demo-ns"
  elasticsearch_version = "7.9"

  cluster_config {
    instance_count           = var.instance_count
    instance_type            = var.instance_type
    dedicated_master_enabled = var.dedicated_master_enabled
    dedicated_master_count   = var.dedicated_master_count
    dedicated_master_type    = var.dedicated_master_type
  }

  ebs_options {
    ebs_enabled = var.ebs_enabled
    volume_size = var.ebs_volume_size
  }

  encrypt_at_rest {
    enabled = var.encrypt_at_rest_enabled
  }

  domain_endpoint_options {
    enforce_https = true
  }
  
  access_policies = <<CONFIG
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "es:*",
            "Principal": "*",
            "Effect": "Allow",
            "Resource": "arn:aws:es:us-east-2:013852311743:domain/es-demo-ns/*"
        }
    ]
}
CONFIG

  node_to_node_encryption {
    enabled = true
  }

  vpc_options {
    subnet_ids = [
      aws_subnet.es-subnet1.id
    ]
  }
}

resource "aws_vpc" "tf_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "tf_vpc"
  }
}

resource "aws_internet_gateway" "tf_internet_gateway" {
  vpc_id = "${aws_vpc.tf_vpc.id}"

  tags = {
    Name = "tf_igw"
  }
}

resource "random_id" "tf_state_random_bucket" {
  byte_length = 8
}

resource "aws_s3_bucket" "tf_state_s3" {
  bucket        = "tf-state-s3-${random_id.tf_state_random_bucket.hex}"
  acl           = "private"
  force_destroy = true
}


output "tf_vpc_id" {
  value = "${aws_vpc.tf_vpc.id}"
}

output "bucket" {
  value = "s3://${aws_s3_bucket.tf_state_s3.id}"
}

output "name" {
  value = "udti.dtihoa.online"
}


#------------S3 bucket --------------------

resource "random_id" "webapp_code_bucket" {
  byte_length = 2
}

resource "aws_s3_bucket" "code" {
  bucket        = "${var.bucket_prefix}-${random_id.webapp_code_bucket.dec}"
  acl           = "private"
  force_destroy = true

  tags = {
    Name = "code bucket"
  }
  provisioner "local-exec" {
    command = <<EOD
cat <<EOF > s3_info.yml 
s3_bucket : ${aws_s3_bucket.code.bucket}
EOF
EOD
  }

}
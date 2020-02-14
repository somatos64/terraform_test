data "template_file" "backup_bucket_policy" {
    template = "${file("${path.root}/policy/s3_bucket_secure_encrypt.json.tpl")}"
    vars = {
        resource = "${aws_s3_bucket.backup_bucket.id}"
  }   
}

resource "aws_s3_bucket" "backup_bucket" {
  bucket        = var.bucket_name
  acl           = "private"
  force_destroy = true

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
      rule {
        apply_server_side_encryption_by_default {
          sse_algorithm     = "aws:kms"
      }
    }
  }

  tags = {
    Name               = "${var.bucket_name}"
    controlled_by      = "terraform"
    dataclassification = "Internal"
    purpose            = "Bucket for storage of backups"
  }
  
}

resource "aws_s3_bucket_policy" "backup_bucket_policy" {
    bucket = aws_s3_bucket.backup_bucket.id
    policy = data.template_file.backup_bucket_policy.rendered
}
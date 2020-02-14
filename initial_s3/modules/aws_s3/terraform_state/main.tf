data "template_file" "main_bucket_policy" {
    template = "${file("${path.root}/policy/s3_bucket_secure_encrypt.json.tpl")}"
    vars = {
        resource = "${aws_s3_bucket.main_bucket.id}"
  }   
}

resource "aws_s3_bucket" "main_bucket" {
  bucket        = var.bucket_name
  acl           = "private"
  force_destroy = true

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
      rule {
        apply_server_side_encryption_by_default {
          sse_algorithm     = "AES256"
      }
    }
  }

  tags = {
    Name               = "${var.bucket_name}"
    controlled-by      = "terraform"
    purpose            = "Initial Bucket Created to hold Terraform Statefiles"
  }
  
}

resource "aws_s3_bucket_policy" "main_bucket_policy" {
    bucket = aws_s3_bucket.main_bucket.id
    policy = data.template_file.main_bucket_policy.rendered
}
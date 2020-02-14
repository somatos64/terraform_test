{
    "Version":"2012-10-17",
    "Statement":[
        {
            "Sid": "Deny any S3 action which has secure transport false in the request",
            "Effect": "Deny",
            "Principal": "*",
            "Action": "s3:*",
            "Resource": [
                "arn:aws:s3:::${resource}",
                "arn:aws:s3:::${resource}/*"
            ],
            "Condition": {
                "Bool": {
                    "aws:SecureTransport": "false"
                }
            }
        }
    ]
}
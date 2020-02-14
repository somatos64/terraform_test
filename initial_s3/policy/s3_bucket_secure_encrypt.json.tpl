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
        },
        {
            "Sid": "Deny any S3 put actions when server side encryption is not requested",
            "Effect": "Deny",
            "Principal": "*",
            "Action": "s3:Put*",
            "Resource": "arn:aws:s3:::${resource}/*",
            "Condition": {
                "Null": {
                    "s3:x-amz-server-side-encryption": "true"
                }
            }
        }
    ]
}
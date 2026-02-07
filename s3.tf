resource "aws_s3_bucket" "mybuck" {
    bucket = "prasad.77.k8s"
}

resource "aws_s3_bucket_versioning" "version"{
    bucket = aws_s3_bucket.mybuck.id
    versioning_configuration {
        status = "Enabled"
    }
}


----backend s3 for state file---

terraform {
    backend "s3" {
        bucket = "prasad.77.k8s"
        key = "important/statefile.tfstate"
        region = "us-east-1"
    }
}

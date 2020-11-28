
# Bucket for Frontend website

resource "aws_s3_bucket" "WebSiteBucketName" {
  bucket = "${var.WebSiteBucketName}"
  acl    = "public-read"
  policy = "${file("s3bucketpolicy.json")}"

  website {
    index_document = "index.html"
    error_document = "error.html"

  }

  tags = {
    Name = "QMS Frontend"
    Environment = "${var.tagEnvironment}"
    Project = "${var.tagProject}"
  }
}



# Bucket for File Server 

resource "aws_s3_bucket" "FileBucketName" {
  bucket = "${var.FileBucketName}"
  acl    = "private"

  tags = {
    Name = "QMS Files Server"
    Environment = "${var.tagEnvironment}"
    Project = "${var.tagProject}"
  }
}
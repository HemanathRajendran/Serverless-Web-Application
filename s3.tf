
# Create an S3 bucket for hosting the web application
resource "aws_s3_bucket" "web_app_bucket" {
  bucket = "hem2695junebucket" # Change this to a unique name
}

resource "aws_s3_bucket_website_configuration" "web_app_bucket_website" {
  bucket = aws_s3_bucket.web_app_bucket.id

  index_document {
    suffix = "index.html"
  }
}

# Set public access block for the S3 bucket
resource "aws_s3_bucket_public_access_block" "web_app_bucket_public_access" {
  bucket = aws_s3_bucket.web_app_bucket.id

  block_public_acls       = false
  ignore_public_acls      = false
  block_public_policy     = false
  restrict_public_buckets = false
}

# CORS configuration for the S3 bucket
resource "aws_s3_bucket_cors_configuration" "web_app_bucket_cors" {
  bucket = aws_s3_bucket.web_app_bucket.id

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "POST", "PUT", "DELETE"]
    allowed_origins = ["*"]
    expose_headers  = []
    max_age_seconds = 3000
  }
}

# Upload index.html to S3
resource "aws_s3_object" "index_html" {
  bucket = aws_s3_bucket.web_app_bucket.id # Use .id instead of .bucket
  key    = "index.html"
  source = "index.html" # Change this to the path of your index.html file
  content_type = "text/html"
#   acl    = "public-read" # This can be removed if using public access block
}

# Upload script.js to S3
resource "aws_s3_object" "script_js" {
  bucket = aws_s3_bucket.web_app_bucket.id  # Use .id instead of .bucket
  key    = "scripts.js"
  source = "scripts.js" # Change this to the path of your script.js file
  content_type = "application/javascript"
#   acl    = "public-read" # This can be removed if using public access block
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.web_app_bucket.id
  depends_on = [aws_s3_bucket_public_access_block.web_app_bucket_public_access]

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "PublicReadGetObject",
        Effect    = "Allow",
        Principal = "*",
        Action    = "s3:GetObject",
        Resource  = "${aws_s3_bucket.web_app_bucket.arn}/*"
      }
    ]
  })
}


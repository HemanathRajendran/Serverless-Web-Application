# # Output the S3 website URL and API endpoint
# output "s3_website_url" {
#   value = aws_s3_bucket.web_app_bucket.website_endpoint
# }

# output "api_endpoint" {
#   value = "${aws_api_gateway_deployment.api_deployment.invoke_url}/students"
# }
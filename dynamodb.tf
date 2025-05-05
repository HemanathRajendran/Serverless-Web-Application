# Create a DynamoDB table
resource "aws_dynamodb_table" "student_data" {
  name         = "studentData"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "studentid"
    type = "S"
  }

  hash_key = "studentid"
}
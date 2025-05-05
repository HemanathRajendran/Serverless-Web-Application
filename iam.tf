# Create an IAM role for Lambda execution

resource "aws_iam_role" "lambda_exec" {
  name = "lambda_exec_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Effect    = "Allow"
        Sid       = ""
      },
    ]
  })
}

# Attach policy to allow Lambda to access DynamoDB
resource "aws_iam_role_policy" "lambda_full_access_policy" {
  name = "lambda_full_access_policy"
  role = aws_iam_role.lambda_exec.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "dynamodb:*"  # Full access to all DynamoDB actions
        Effect = "Allow"
        Resource = "*"
      },
      {
        Action = "execute-api:*"  # Full access to all API Gateway actions
        Effect = "Allow"
        Resource = "*"
      }
    ]
  })
}
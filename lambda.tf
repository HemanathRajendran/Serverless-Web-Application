# Create the insertStudentData Lambda function
resource "aws_lambda_function" "insert_student_data" {
  function_name = "insertStudentData"
  handler       = "insert_student_data.lambda_handler" # Change this if your handler is different
  runtime       = "python3.8" # Change this to your desired Python version

  # Zip your Lambda function code and provide the path
  filename      = "InsertStudentData.zip" # Change this to the path of your zipped Lambda function code

  # IAM role for Lambda
  role          = aws_iam_role.lambda_exec.arn
  
#   environment {
#     variables = {
#       DYNAMODB_TABLE = aws_dynamodb_table.student_data.name
#     }
#   }
}

# Create the getStudent Lambda function
resource "aws_lambda_function" "get_student" {
  function_name = "getStudent"
  handler       = "get_student.lambda_handler" # Change this if your handler is different
  runtime       = "python3.8" # Change this to your desired Python version

  # Zip your Lambda function code and provide the path
  filename      = "getStudents.zip" # Change this to the path of your zipped Lambda function code

  # IAM role for Lambda
  role          = aws_iam_role.lambda_exec.arn

#   environment {
#     variables = {
#       DYNAMODB_TABLE = aws_dynamodb_table.student_data.name
#     }
#   }
}
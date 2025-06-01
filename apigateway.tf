resource "aws_api_gateway_rest_api" "api" {
  name        = "myapi"
  description = "This is my API for demonstration purposes"
}

#test

resource "aws_api_gateway_resource" "students" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = "mydemoresource"
}


# Create a GET method for the getStudent Lambda function
resource "aws_api_gateway_method" "get_students" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.students.id
  http_method   = "GET"
  authorization = "NONE"
}

# Create a POST method for the insertStudentData Lambda function
resource "aws_api_gateway_method" "post_student" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.students.id
  http_method   = "POST"
  authorization = "NONE"
}

# Integrate the GET method with the getStudent Lambda function
resource "aws_api_gateway_integration" "get_students_integration" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.students.id
  http_method = aws_api_gateway_method.get_students.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.get_student.invoke_arn
}

# Integrate the POST method with the insertStudentData Lambda function
resource "aws_api_gateway_integration" "post_student_integration" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.students.id
  http_method = aws_api_gateway_method.post_student.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.insert_student_data.invoke_arn
}

# Enable CORS for the GET method
resource "aws_api_gateway_method_response" "get_students_response" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.students.id
  http_method = aws_api_gateway_method.get_students.http_method
  status_code = "200"

  response_parameters = {
        "method.response.header.Access-Control-Allow-Origin" = true
    }
}

# Enable CORS for the POST method
resource "aws_api_gateway_method_response" "post_student_response" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.students.id
  http_method = aws_api_gateway_method.post_student.http_method
  status_code = "200"

  response_parameters = {
        "method.response.header.Access-Control-Allow-Origin" = true
    }
}

# Deploy the API
resource "aws_api_gateway_deployment" "api_deployment" {
  rest_api_id = aws_api_gateway_rest_api.api.id
#   stage_name  = "prod"
}


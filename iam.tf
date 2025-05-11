resource "aws_iam_policy" "terraform_dynamodb_policy" {
  name        = "TerraformDynamoDBPolicy"
  description = "Allows DynamoDB actions for Terraform state locking"
  policy      = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "dynamodb:CreateTable",
          "dynamodb:DescribeTable",
          "dynamodb:PutItem",
          "dynamodb:GetItem"
        ],
        Resource = "arn:aws:dynamodb:us-east-1:144317819575:table/terraform-locks"
      }
    ]
  })
}

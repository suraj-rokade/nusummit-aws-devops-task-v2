# IAM Role for EC2 to allow CodeDeploy access
resource "aws_iam_role" "ec2_codedeploy_role" {
  name = "EC2CodeDeployRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

# Attach the AWS-managed policy
resource "aws_iam_role_policy_attachment" "ec2_codedeploy_attach" {
  role       = aws_iam_role.ec2_codedeploy_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforAWSCodeDeploy"
}

# Create Instance Profile (so EC2 can use this role)
resource "aws_iam_instance_profile" "ec2_codedeploy_profile" {
  name = "EC2CodeDeployInstanceProfile"
  role = aws_iam_role.ec2_codedeploy_role.name
}

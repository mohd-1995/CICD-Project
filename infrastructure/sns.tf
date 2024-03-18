resource "aws_sns_topic" "sns" {
  name = "docker-pull-notification"
}

resource "aws_iam_role" "sns-role" {
  name = "ec2-sns-role"

  lifecycle {
    create_before_destroy = true
  }

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_policy" "sns-policy" {
  name        = "ec2-sns-policy"
  description = "EC2 policy for SNS and SSM"

  lifecycle {
    create_before_destroy = true
  }

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "sns:Subscribe",
          "sns:Receive",
          "ssm:SendCommand",
          "ssm:GetCommandInvocation"
        ],
        Effect   = "Allow",
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "sns-policy-attach" {
  role       = aws_iam_role.sns-role.name
  policy_arn = aws_iam_policy.sns-policy.arn
}

resource "aws_iam_instance_profile" "sns-profile" {
  name = "ec2-sns-profile"
  role = aws_iam_role.sns-role.name
}


resource "aws_sns_topic_subscription" "email" {
  topic_arn = aws_sns_topic.sns.arn
  protocol = "email"
  endpoint = "balouch177@gmail.com"
}
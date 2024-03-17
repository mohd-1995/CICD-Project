resource "aws_sns_topic" "topic" {
  name = "docker-pull-complete-notification"
  
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_sns_topic_subscription" "email" {
  topic_arn = aws_sns_topic.topic.arn
  protocol = "email"
  endpoint = "balouch177@gmail.com"

  lifecycle {
    create_before_destroy = true
  }

}


resource "aws_iam_role" "sns-role" {
  name = "ec2_sns_role"

  lifecycle {
    create_before_destroy = true
  }

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com",
        },
      },
    ],
  })
}

resource "aws_iam_policy" "sns-publish" {
  name        = "sns_publish_policy"
  description = "A policy that allows publishing to a specific SNS topic."

  lifecycle {
    create_before_destroy = true
  }

  policy = jsonencode({
    Version   = "2012-10-17",
    Statement = [
      {
        Action   = "sns:Publish",
        Resource = aws_sns_topic.topic.arn,
        Effect   = "Allow",
      },
    ],
  })
}


resource "aws_iam_role_policy_attachment" "sns-attach-policy" {
  role = aws_iam_role.sns-role.name
  policy_arn = aws_iam_policy.sns-publish.arn

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_iam_instance_profile" "sns-profile" {
  name = "EC2-SNS-Profile"
  role = aws_iam_role.sns-role.name

  lifecycle {
    create_before_destroy = true
  }
}
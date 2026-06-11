resource "aws_cloudwatch_log_group" "app" {
  name              = "/shopflow/app"
  retention_in_days = 7
  tags = { Name = "${var.project_name}-log-group" }
}

resource "aws_sns_topic" "alerts" {
  name = "${var.project_name}-alerts"
  tags = { Name = "${var.project_name}-alerts" }
}

resource "aws_sns_topic_subscription" "email" {
  topic_arn = aws_sns_topic.alerts.arn
  protocol  = "email"
  endpoint  = var.alert_email
}

resource "aws_cloudwatch_metric_alarm" "cpu_high" {
  alarm_name          = "${var.project_name}-cpu-high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 120
  statistic           = "Average"
  threshold           = 70
  alarm_description   = "CPU exceeded 70%"
  alarm_actions       = [aws_sns_topic.alerts.arn]
  tags = { Name = "${var.project_name}-cpu-alarm" }
}

resource "aws_cloudwatch_dashboard" "main" {
  dashboard_name = "${var.project_name}-dashboard"
  dashboard_body = jsonencode({
    widgets = [
      {
        type   = "metric"
        x      = 0
        y      = 0
        width  = 12
        height = 6
        properties = {
          title   = "EC2 CPU Usage"
          region  = var.aws_region
          metrics = [["AWS/EC2", "CPUUtilization"]]
          period  = 300
          stat    = "Average"
          view    = "timeSeries"
        }
      },
      {
        type   = "metric"
        x      = 12
        y      = 0
        width  = 12
        height = 6
        properties = {
          title   = "ALB Request Count"
          region  = var.aws_region
          metrics = [["AWS/ApplicationELB", "RequestCount"]]
          period  = 300
          stat    = "Sum"
          view    = "timeSeries"
        }
      }
    ]
  })
}

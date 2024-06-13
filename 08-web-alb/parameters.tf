## Creating the AWS SSM parameter store (/expense/dev/web_alb_listener_arn) and storing the web application load balancer for http
resource "aws_ssm_parameter" "web_alb_listener_arn" {
    name = "/${var.project_name}/${var.environment}/web_alb_listener_arn"
    type = "String"
    value = aws_lb_listener.http.arn
}

## Creating the AWS SSM parameter store (/expense/dev/web_alb_listener_arn) and storing the web application load balancer for https

resource "aws_ssm_parameter" "web_alb_listener_arn_https" {
    name = "/${var.project_name}/${var.environment}/web_alb_listener_arn_https"
    type = "String"
    value = aws_lb_listener.https.arn
}
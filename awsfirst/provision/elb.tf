resource "aws_lb" "awsfirst-lb" {
  name               = "awsfirst-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.awsfirst-public-subnet-sg.id]
  subnets            = [aws_subnet.awsfirst-subnet-public-a.id, aws_subnet.awsfirst-subnet-public-b.id]

  enable_deletion_protection = false

}

resource "aws_lb_target_group" "awsfirst-lb-target" {
  name        = "awsfirst-lb-target"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = data.aws_vpc.default-vpc.id
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.awsfirst-lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.awsfirst-lb-target.arn
  }
}
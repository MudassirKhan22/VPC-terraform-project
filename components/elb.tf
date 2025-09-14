# Create a new load balancer
resource "aws_lb" "new_lb" {
  name               = var.elb.name
  internal           = var.elb.internal
  load_balancer_type = var.elb.load_balancer_type
  security_groups    = [aws_security_group.new_sg.id]
  subnets            = [for subnet in aws_subnet.new_subnet : subnet.id]
  tags = {
    Name = "New Load Balancer"
  }
}

# resource "aws_lb" "new_lb" {
#   name               = "new-lb"
#   internal           = false
#   load_balancer_type = "application"
#   security_groups    = [aws_security_group.new_sg.id]
#   subnets            = [aws_subnet.new_subnet1.id, aws_subnet.new_subnet2.id]

#   tags = {
#     Name = "New Load Balancer"
#   }
# }

# Create a new target group
resource "aws_lb_target_group" "new_tg" {
  name     = var.target_group.name
  port     = var.target_group.port
  protocol = var.target_group.protocol
  vpc_id   = aws_vpc.new_vpc.id

  health_check {
    path = "/"
    port = "traffic-port"
  }
}

# resource "aws_lb_target_group" "new_tg" {
#   name     = "new-tg"
#   port     = 80
#   protocol = "HTTP"
#   vpc_id   = aws_vpc.new_vpc.id

#   health_check {
#     path = "/"
#     port = "traffic-port"
#   }
# }

# Attach target group to instances
resource "aws_lb_target_group_attachment" "new_lb_tg_attachment" {
  for_each = aws_instance.new_ec2_instance

  target_group_arn = aws_lb_target_group.new_tg.arn
  target_id        = each.value.id
  port             = 80
}

# # Attach target group to instance 1
# resource "aws_lb_target_group_attachment" "new_lb_tg_attachment1" {
#   target_group_arn = aws_lb_target_group.new_tg.arn
#   target_id        = aws_instance.new_ec2_instance1.id
#   port             = 80
# }


# # Attach target group to instance 2
# resource "aws_lb_target_group_attachment" "new_lb_tg_attachment2" {
#   target_group_arn = aws_lb_target_group.new_tg.arn
#   target_id        = aws_instance.new_ec2_instance2.id
#   port             = 80
# }

# Create a new listener
resource "aws_lb_listener" "new_listener" {
  load_balancer_arn = aws_lb.new_lb.arn
  port              = var.listener.port
  protocol          = var.listener.protocol

  default_action {
    target_group_arn = aws_lb_target_group.new_tg.arn
    type             = "forward"
  }
}

# # Create a new listener
# resource "aws_lb_listener" "new_listener" {
#   load_balancer_arn = aws_lb.new_lb.arn
#   port = 80
#   protocol = "HTTP"

#   default_action {
#     target_group_arn = aws_lb_target_group.new_tg.arn
#     type             = "forward"
#   }
# }







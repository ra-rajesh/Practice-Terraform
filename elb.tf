
# resource "aws_lb" "test" {
#   name               = "${var.vpc_name}-elb"
#   internal           = false
#   load_balancer_type = "application"
#   security_groups    = [aws_security_group.test_sg.id]
#   subnets            = [aws_subnet.public_subnet[*].id]

#   enable_deletion_protection = true

#   #   access_logs {
#   #     bucket  = aws_s3_bucket.lb_logs.id
#   #     prefix  = "test-lb"
#   #     enabled = true
#   #   }

#   tags = {
#     Name        = "${var.vpc_name}-elb"
#     Owner       = local.Owner
#     costcenter  = local.costcenter
#     TeamDL      = local.TeamDL
#     environment = var.environment
#   }
# }




# # Application Load Balancer
# resource "aws_lb" "app_alb" {
#   name               = "${var.vpc_name}-alb"
#   internal           = false
#   load_balancer_type = "application"
#   security_groups    = [aws_security_group.app_sg.id]
#   subnets            = aws_subnet.public_subnet[*].id

#   enable_deletion_protection = true

#   tags = {
#     Name        = "${var.vpc_name}-alb"
#     Owner       = local.Owner
#     costcenter  = local.costcenter
#     TeamDL      = local.TeamDL
#     environment = var.environment
#   }
# }

# # Target Group
# resource "aws_lb_target_group" "app_tg" {
#   name        = "${var.vpc_name}-tg"
#   port        = 80
#   protocol    = "HTTP"
#   vpc_id      = aws_vpc.testing.id

#   health_check {
#     path                = "/"
#     interval            = 30
#     timeout             = 5
#     healthy_threshold   = 3
#     unhealthy_threshold = 2
#     matcher             = "200"
#   }

#   tags = {
#     Name        = "${var.vpc_name}-tg"
#     Owner       = local.Owner
#     costcenter  = local.costcenter
#     TeamDL      = local.TeamDL
#     environment = var.environment
#   }
# }

# # Listener
# resource "aws_lb_listener" "http_listener" {
#   load_balancer_arn = aws_lb.app_alb.arn
#   port              = 80
#   protocol          = "HTTP"

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.app_tg.arn
#   }
# }

# # ALB Security Group
# resource "aws_security_group" "app_sg" {
#   name        = "${var.vpc_name}-alb-sg"
#   description = "Security group for the ALB"
#   vpc_id      = aws_vpc.testing.id

#   ingress {
#     description = "Allow HTTP traffic"
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   ingress {
#     description = "Allow HTTPS traffic"
#     from_port   = 443
#     to_port     = 443
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   egress {
#     description = "Allow all outbound traffic"
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name        = "${var.vpc_name}-alb-sg"
#     Owner       = local.Owner
#     costcenter  = local.costcenter
#     TeamDL      = local.TeamDL
#     environment = var.environment
#   }
# }

# # Attach EC2 instances to the Target Group
# resource "aws_lb_target_group_attachment" "app_tg_attachment" {
#   count            = length(aws_instance.app_instances)
#   target_group_arn = aws_lb_target_group.app_tg.arn
#   target_id        = aws_instance.app_instances[count.index].id
#   port             = 80
# }

# # Example EC2 Instances
# resource "aws_instance" "app_instances" {
#   count         = 2
#   ami           = var.ami_id
#   instance_type = "t2.micro"
#   subnet_id     = element(aws_subnet.public_subnet.*.id, count.index)
#   security_groups = [
#     aws_security_group.app_sg.id
#   ]

#   tags = {
#     Name        = "${var.vpc_name}-app-instance-${count.index + 1}"
#     Owner       = local.Owner
#     costcenter  = local.costcenter
#     TeamDL      = local.TeamDL
#     environment = var.environment
#   }
# }

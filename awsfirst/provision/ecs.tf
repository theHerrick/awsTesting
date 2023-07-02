resource "aws_ecs_task_definition" "awsfirst_task_def" {
  family = var.ecs_task_def_name
  requires_compatibilities = ["FARGATE"]
  execution_role_arn = var.ecs_execution_role
  network_mode = "awsvpc"
  cpu = 512
  memory = 1024
  container_definitions = <<TASK_DEFINITION
  [
     {
            "name": "awsfirst",
            "image": "${aws_ecr_repository.awsfirst_ecr.repository_url}",
            "portMappings": [
                {
                    "name": "awsfirst-80-tcp",
                    "containerPort": 80,
                    "hostPort": 80,
                    "protocol": "tcp",
                    "appProtocol": "http"
                }
            ],
            "essential": true,
            "environment": [],
            "environmentFiles": [],
            "mountPoints": [],
            "volumesFrom": [],
            "ulimits": [],
            "logConfiguration": {
                "logDriver": "awslogs",
                "options": {
                    "awslogs-create-group": "true",
                    "awslogs-group": "/ecs/awsfirst-task",
                    "awslogs-region": "eu-west-2",
                    "awslogs-stream-prefix": "ecs"
                }
            }
        }
        ]
        TASK_DEFINITION

}

resource "aws_cloudwatch_log_group" "ecs-logs" {
  name = "awsfirst-ecs-logs"
}

resource "aws_ecs_cluster" "awsfirst_cluster" {
  name = var.ecs_cluster_name
  configuration {
    execute_command_configuration {
      logging    = "OVERRIDE"

      log_configuration {
        cloud_watch_encryption_enabled = false
        cloud_watch_log_group_name     = aws_cloudwatch_log_group.ecs-logs.name
      }
    }
  }
}

resource "aws_ecs_service" "awsfirst_service" {
  name            = var.ecs_service_name
  cluster         = aws_ecs_cluster.awsfirst_cluster.id
  task_definition = aws_ecs_task_definition.awsfirst_task_def.arn
  desired_count   = 1
  launch_type = "FARGATE"

  load_balancer {
    target_group_arn = aws_lb_target_group.awsfirst-lb-target.arn
    container_name   = "awsfirst"
    container_port   = 80
  }

  network_configuration {
    subnets = [aws_subnet.awsfirst-subnet-private.id]
    security_groups = [aws_security_group.awsfirst-private-subnet-sg.id]
    assign_public_ip = false
  }
}

resource "aws_ecs_task_definition" "this_bridge" {
  family                   = "${var.name}-proxy-bridge"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = var.worker_cpu
  memory                   = var.worker_memory
  execution_role_arn       = aws_iam_role.this_task_execution.arn
  task_role_arn            = aws_iam_role.this_task.arn

  container_definitions    = jsonencode([
      {
        name                          = "bridge"
        image                         = "public.ecr.aws/strongdm/relay:latest"
        essential                     = true
        networkMode                   = "awsvpc"

        logConfiguration = {
          logDriver = "awslogs"
          options = {
            mode                  = "non-blocking"
            awslogs-group         = aws_cloudwatch_log_group.this.name
            awslogs-stream-prefix = "${var.name}-"
            awslogs-region        = data.aws_region.current.name
         }
       }

        environment = [
        {
          name  = "SDM_DOCKERIZED"
          value = "true"
        },
        {
          name  = "SDM_BIND_ADDRESS"
          value = ":8443"
        },
        {
          name  = "SDM_BRIDGE"
          value = "local"
        },
        {
          name  = "SDM_PROXY_CLUSTER_ACCESS_KEY"
          value = var.sdm_proxy_cluster_access_key
        },
        ]

      secrets = [
        {
          name      = "SDM_PROXY_CLUSTER_SECRET_KEY"
          valueFrom = aws_ssm_parameter.secret_key.arn
        },
      ]

        portMappings = [{
          protocol      = "tcp"
          containerPort = 8443
        }]
      }
    ]
  )
}

resource "aws_ecs_task_definition" "this_worker" {
  family                   = "${var.name}-proxy-worker"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = var.worker_cpu
  memory                   = var.worker_memory
  execution_role_arn       = aws_iam_role.this_task_execution.arn
  task_role_arn            = aws_iam_role.this_task.arn

  container_definitions    = jsonencode([
      {
        name                          = "worker"
        image                         = "public.ecr.aws/strongdm/relay:latest"
        essential                     = true
        networkMode                   = "awsvpc"

        logConfiguration = {
          logDriver = "awslogs"
          options = {
            mode                  = "non-blocking"
            awslogs-group         = aws_cloudwatch_log_group.this.name
            awslogs-stream-prefix = "${var.name}-"
            awslogs-region        = data.aws_region.current.name
          }
        }

        environment = [
        {
          name  = "SDM_DOCKERIZED"
          value = "true"
        },
        {
          name  = "SDM_BIND_ADDRESS"
          value = ":8443"
        },
        {
          name  = "SDM_BRIDGE"
          value = "${aws_lb.this.dns_name}:443"
        },
        {
          name  = "SDM_PROXY_CLUSTER_ACCESS_KEY"
          value = var.sdm_proxy_cluster_access_key
        },
        ]

      secrets = [
        {
          name      = "SDM_PROXY_CLUSTER_SECRET_KEY"
          valueFrom = aws_ssm_parameter.secret_key.arn
        },
      ]

        portMappings = [{
          protocol      = "tcp"
          containerPort = 8443
        }]
      }
    ]
  )
}
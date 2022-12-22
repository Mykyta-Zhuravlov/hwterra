resource "aws_ecs_cluster" "cluster" {

  name = var.cluster_name

}


resource "aws_ecs_task_definition" "taskdef" {

  family                   = var.ecs_taskdef_name
  network_mode             = var.ecs_taskdef_network_mode
  requires_compatibilities = var.ecs_taskdef_compatibilities
  cpu                      = var.ecs_taskdef_cpu
  memory                   = var.ecs_taskdef_memory

  container_definitions = jsonencode([
    {

      name      = "${var.container_1_name}"
      image     = "${var.container_1_image}"
      cpu       = "${var.container_1_cpu}"
      memory    = "${var.container_1_memory}"
      essential = true
      environment = [
        {
          "name" : "WORDPRESS_DB_HOST",
          "value" : "${aws_db_instance.database.endpoint}"
        },
        {
          "name" : "WORDPRESS_DB_NAME",
          "value" : "${var.db_name}"
        },
        {
          "name" : "WORDPRESS_DB_USER",
          "value" : "${var.db_user}"
        }
      ],
      secrets = [
        {
          "name" : "WORDPRESS_DB_PASSWORD"
          "valueFrom" : "${aws_ssm_parameter.db_password.arn}"
        }
      ]
      portMappings = [
        {
          containerPort = "${var.container_1_port}"
          hostPort      = "${var.container_1_port}"
        }
      ]
    },

    {

      name      = "${var.container_2_name}"
      image     = "${var.container_2_image}"
      cpu       = "${var.container_2_cpu}"
      memory    = "${var.container_2_memory}"
      essential = true

      portMappings = [
        {
          containerPort = "${var.container_2_port}"
          hostPort      = "${var.container_2_port}"
        }
      ]

    }
  ])
}




resource "aws_ecs_service" "service" {

  name            = var.ecs_service_name
  cluster         = aws_ecs_cluster.cluster.id
  task_definition = aws_ecs_task_definition.taskdef.arn
  desired_count   = var.ecs_service_desired_count

  depends_on = [
    aws_instance.ecs-instance01
  ]


  load_balancer {
    target_group_arn = aws_lb_target_group.alb_tg.arn
    container_name   = var.ecs_service_lb_container_name
    container_port   = var.ecs_service_lb_container_port
  }


}


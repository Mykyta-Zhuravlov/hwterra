resource "aws_ecs_task_definition" "taskdef" {

  family                   = var.ecs_taskdef_name
  network_mode             = var.ecs_taskdef_network_mode
  requires_compatibilities = var.ecs_taskdef_compatibilities
  execution_role_arn       = var.ecs_taskdef_execution_role
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
          "valuefrom" : "${data.aws_ssm_parameter.db_user_ssm.value}"
        },
        {
          "name" : "WORDPRESS_DB_PASSWORD",
          "valuefrom" : "${data.aws_ssm_parameter.db_password_ssm.value}"
        } /* ,
        {
          "name" : "WORDPRESS_TITLE",
          "value" : "${var.wp_title}"
        },
        {
          "name" : "WORDPRESS_USER",
          "valuefrom" : ${data.aws_ssm_parameter.wp_user_ssm.value}"
        },
        {
          "name" : "WORDPRESS_PASSWORD",
          "valuefrom" : ${data.aws_ssm_parameter.wp_password_ssm.value}"
        },
        {
          "name" : "WORDPRESS_MAIL",
          "value" : "${var.wp_mail}"
        } */
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


data "aws_ssm_parameter" "wp_password_ssm" {
  name = var.wp_password_ssm
}
data "aws_ssm_parameter" "wp_user_ssm" {
  name = var.wp_user_ssm
}



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

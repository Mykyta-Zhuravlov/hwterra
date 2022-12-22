variable "region" {}
variable "db_storage" {}
variable "db_skip_final_snapshot" {}
variable "db_engine" {}
variable "db_user" {}
variable "db_version" {}
variable "db_inst_type" {}
variable "db_name" {}
variable "sg_db_name" {}
variable "sg_web_name" {}
variable "sg_ecs_instance_name" {}
variable "port_db_ingress" {}
variable "port_web_ingress_1" {}
variable "port_web_ingress_2" {}
variable "vpc_name" {}
variable "igw_name" {}
variable "route_table_name" {}
variable "map_public_ip_on_launch_public" {}
variable "map_public_ip_on_launch_private" {}
variable "private_subnets_name" {}
variable "public_subnets_name" {}
variable "cidr_vpc" {}
variable "cidr_web_ingress_1" {}
variable "cidr_web_ingress_2" {}
variable "cidr_public_1" {}
variable "cidr_public_2" {}
variable "cidr_public_3" {}
variable "cidr_private_1" {}
variable "cidr_private_2" {}
variable "cidr_private_3" {}
variable "ssh_key" {}
variable "ssh_key_name" {}
variable "load_balancer_name" {}
variable "load_balancer_type" {}
variable "load_balancer_internal" {}
variable "load_balancer_target_name" {}
variable "load_balancer_target_port" {}
variable "load_balancer_target_type" {}
variable "load_balancer_target_protocol" {}
variable "load_balancer_target_default_action_type" {}
variable "load_balancer_https_port" {}
variable "load_balancer_https_protocol" {}
variable "load_balancer_https_status_code" {}
variable "load_balancer_https_policy" {}
variable "domain_name" {}
variable "cluster_name" {}
variable "ecs_instance_name" {}
variable "ecs_instance_type" {}
variable "ecs_instance_iam_profile" {}
variable "ecs_instance_associate_public_ip" {}
variable "ecs_taskdef_name" {}
variable "ecs_taskdef_network_mode" {}
variable "ecs_taskdef_cpu" {}
variable "ecs_taskdef_memory" {}
variable "ecs_taskdef_compatibilities" {}
variable "ecs_service_name" {}
variable "ecs_service_desired_count" {}
variable "ecs_service_lb_container_name" {}
variable "ecs_service_lb_container_port" {}
variable "container_1_name" {}
variable "container_1_image" {}
variable "container_1_cpu" {}
variable "container_1_memory" {}
variable "container_1_port" {}
variable "container_2_name" {}
variable "container_2_image" {}
variable "container_2_cpu" {}
variable "container_2_memory" {}
variable "container_2_port" {}

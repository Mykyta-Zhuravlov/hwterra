// DOMAIN CONFIGURATION
domain_name = "your_domain_name"


// REGION CONFIGURATION
region = "eu-west-1"


// VPC CONFIGURATION
vpc_name         = "wordpress"
cidr_vpc         = "10.1.0.0/16"
igw_name         = "wordpress_vpc_igw"
route_table_name = "route_all"


// PUBLIC SUBNETS CONFIGURATION
public_subnets_name            = "public_subnet"
map_public_ip_on_launch_public = "true"
cidr_public_1                  = "10.1.11.0/24"
cidr_public_2                  = "10.1.12.0/24"
cidr_public_3                  = "10.1.13.0/24"


// PRIVATE SUBNETS CONFIGURATION
private_subnets_name            = "private_subnet"
map_public_ip_on_launch_private = "false"
cidr_private_1                  = "10.1.21.0/24"
cidr_private_2                  = "10.1.22.0/24"
cidr_private_3                  = "10.1.23.0/24"


// SSH KEY CONFIGURATION
ssh_key_name    = "key_name"
public_key_path = "./keyway"


// RDS & SECURITY GROUP CONFIGURATION
db_storage             = "20"
db_engine              = "mysql"
db_version             = "5.7"
db_inst_type           = "db.t2.micro"
db_name                = "wordpress"
db_user_ssm            = "/db_user"
db_password_ssm        = "/db_password"
db_skip_final_snapshot = "true"
sg_db_name             = "sg-db"
port_db_ingress        = "3306"



// WEB SECURITY GROUP CONFIGURATION
sg_web_name        = "sg-web"
port_web_ingress_1 = "80"
cidr_web_ingress_1 = ["0.0.0.0/0"]
port_web_ingress_2 = "443"
cidr_web_ingress_2 = ["0.0.0.0/0"]


// LOAD BALANCER CONFIGURATION
load_balancer_name                       = "wordpress-alb"
load_balancer_type                       = "application"
load_balancer_internal                   = "false"
load_balancer_target_name                = "alp-target-group"
load_balancer_target_port                = "80"
load_balancer_target_type                = "instance"
load_balancer_target_protocol            = "HTTP"
load_balancer_target_default_action_type = "redirect"
load_balancer_https_port                 = "443"
load_balancer_https_protocol             = "HTTPS"
load_balancer_https_status_code          = "HTTP_301"
load_balancer_https_policy               = "ELBSecurityPolicy-2016-08"


// CLUSTER CONFIGURATION
cluster_name = "wordpress"


// ECS INSTANCE CONFIGURATION
sg_ecs_instance_name             = "ecs-sg"
ecs_instance_name                = "ecs_instance"
ecs_instance_ami                 = "ami-08c011700cf146b89"
ecs_instance_type                = "t2.micro"
ecs_instance_associate_public_ip = "true"
ecs_instance_iam_profile         = "ecsInstanceRole"


// ECS TASK DEFINITION CONFIGURATION
ecs_taskdef_name            = "wordpress_taskdef"
ecs_taskdef_network_mode    = "host"
ecs_taskdef_cpu             = "512"
ecs_taskdef_memory          = "950"
ecs_taskdef_compatibilities = ["EC2"]
ecs_taskdef_execution_role  = "arn:aws:iam::706226167828:role/ecsTaskExecutionRole"
container_1_name            = "wordpress"
container_1_image           = "706226167828.dkr.ecr.eu-west-1.amazonaws.com/wordpress:latest"
container_1_cpu             = 128
container_1_memory          = 512
container_1_port            = 9000
container_2_name            = "nginx"
container_2_image           = "706226167828.dkr.ecr.eu-west-1.amazonaws.com/nginxfastcgi:latest"
container_2_cpu             = 128
container_2_memory          = 256
container_2_port            = 80


// ECS SERVICE CONFIGURATION
ecs_service_name              = "wordpress_service"
ecs_service_desired_count     = "1"
ecs_service_lb_container_name = "nginx"
ecs_service_lb_container_port = "80"


// AZS CONFIG
az_1 = "eu-west-1a"
az_2 = "eu-west-1b"
az_3 = "eu-west-1c"
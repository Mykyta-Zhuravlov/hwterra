resource "aws_key_pair" "wordpress" {

  key_name   = var.ssh_key_name
  public_key = var.ssh_key

}


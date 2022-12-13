resource "aws_key_pair" "wordpress" {

  key_name   = var.ssh_key_name
  public_key = file(var.public_key_path)

}


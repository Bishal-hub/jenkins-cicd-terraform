locals {
  # Flattens the map so Terraform can loop through individual instances
  instances = flatten([
    for group_name, config in var.server_groups : [
      for i in range(1, config.instance_count + 1) : {
        id            = "${group_name}-${i}"
        instance_type = config.instance_type
        name          = "terraform-${group_name}-${i}"
      }
    ]
  ])
}

resource "aws_instance" "multi_server" {
  for_each = { for inst in local.instances : inst.id => inst }

  ami           = "ami-0f58b397bc5c1f2e8" # Amazon Linux 2023 AP-South-1
  instance_type = each.value.instance_type

  tags = {
    Name = each.value.name
  }
}
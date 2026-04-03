output "deployed_instances" {
  value = {
    for k, v in aws_instance.multi_server : k => {
      instance_id = v.id
      public_ip   = v.public_ip
      type        = v.instance_type
    }
  }
}
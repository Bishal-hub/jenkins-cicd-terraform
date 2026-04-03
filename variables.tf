variable "aws_region" {
  default = "ap-south-1"
}

variable "server_groups" {
  description = "Configuration for different server groups"
  type = map(object({
    instance_type  = string
    instance_count = number
  }))
  default = {
    "web" = {
      instance_type  = "t3.micro"
      instance_count = 2
    },
    "app" = {
      instance_type  = "t3.small"
      instance_count = 1
    }
  }
}
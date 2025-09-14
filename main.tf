module "test" {
  source             = "./components"
  vpc_cidr_block     = "10.0.0.0/16"
  availability_zones = ["ap-south-1a", "ap-south-1b"]
  subnet_cidr_block  = ["10.0.1.0/24", "10.0.2.0/24"]
  key_pair_name      = "project.pub"
  instance_ami       = ["ami-0b982602dbb32c5bd", "ami-02d26659fd82cf299"]
  instance_type      = ["t2.micro", "t2.small"]
  volumes            = [
    { size = 8, type = "gp2" },
    { size = 12, type = "gp3" }
  ]

  S3                 = "my-unique-bucket-name-20241214-7891"

  elb = {
    name               = "new-load-balancer"
    internal           = false
    load_balancer_type = "application"
    subnets            = []  # Will be populated internally by the module
    security_groups    = []  # Will be populated internally by the module
  }

  target_group = {
    name     = "new-target-group"
    port     = 80
    protocol = "HTTP"
  }

  listener = {
    port     = 80
    protocol = "HTTP"
  }
}
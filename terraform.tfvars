vpc_cidr = "10.0.0.0/16"

public_subnet_cidrs = [
  "10.0.1.0/24",
  "10.0.2.0/24",
  "10.0.3.0/24"
]

availability_zones = [
  "us-east-1a",
  "us-east-1b",
  "us-east-1c"
]

ami_id = "ami-084568db4383264d4"  # Amazon Linux 2 (example)
instance_type = "t2.micro"

s3_bucket      = "my-terraform-state-bucket-123456"
dynamodb_table = "terraform-locks"


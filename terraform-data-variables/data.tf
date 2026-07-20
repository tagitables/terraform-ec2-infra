data "aws_vpc" "selected" {
  filter {
    name   = "tag:Name"
    values = ["tag-terraform-vpc"]
  }
}

data "aws_subnet" "public" {
  filter {
    name   = "tag:Name"
    values = ["tag-terraform-subnet-public1-us-east-1a"]
  }

  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.selected.id]
  }
}
terraform {
  backend "s3" {
    bucket         = "21b-centos"
    key            = "eks_cluster/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-s3-backend-locking"
    encrypt        = true
  }
}

# locking part

resource "aws_dynamodb_table" "tf_remote_state_locking" {
  hash_key = "LockID"
  name     = "terraform-eks-21b-backend-locking"
  attribute {
    name = "LockID"
    type = "S"
  }
  billing_mode = "PAY_PER_REQUEST"
}

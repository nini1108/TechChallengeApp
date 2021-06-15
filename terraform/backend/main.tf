
resource "aws_s3_bucket" "s3_bucket_tfstate" {
  bucket = "vjassessment-tfstate"    
  acl    = "private"

  versioning {
    enabled = true
  }

  tags = {
    env = var.env
    project_name = var.project_name
  }
}

terraform {
  backend "s3" {
    bucket         = "vjassessment-tfstate"
    key            = "infra.tfstate"
    region         = "ap-southeast-2"
  }
}
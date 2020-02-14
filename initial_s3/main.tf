provider "aws" {
  region = var.aws_region
}

module "main_s3" {
  source	= "./modules/aws_s3/terraform_state"
  #Bucket name doesn't support _ so breaking convention and using -
  bucket_name = "${var.aws_region}-${var.project_name}-statefiles"
}

module "bootstrap" {
  source	= "./modules/aws_s3/bootstrap"
  #Bucket name doesn't support _ so breaking convention and using -
  bucket_name = "${var.aws_region}-${var.project_name}-bootstrap"
}

module "backup" {
  source	= "./modules/aws_s3/backup"
  #Bucket name doesn't support _ so breaking convention and using -
  bucket_name = "${var.aws_region}-${var.project_name}-backups"
}

module "artifact_repository" {
  source	= "./modules/aws_s3/artifact_repository"
  #Bucket name doesn't support _ so breaking convention and using -
  bucket_name = "${var.aws_region}-${var.project_name}-artifact-repository"
}

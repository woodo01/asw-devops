terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
    }
    local = {
      source  = "hashicorp/local"
      version = ">= 2.5.0"
    }
    null = {
      source  = "hashicorp/null"
      version = ">= 3.2.0"
    }
    template = {
      source  = "hashicorp/template"
      version = "~> 2.2.0"
    }
    external = {
      source  = "hashicorp/external"
      version = "~> 2.2.0"
    }
  }

  backend "s3" {
    bucket       = "rsschool-bootstrap-terraform-state"
    key          = "global/rsschool/terraform-project.tfstate"
    region       = "eu-central-1"
    encrypt      = true
    use_lockfile = true
  }

  required_version = ">= 1.12.0"
}

provider "aws" {
  region = var.aws_region
  default_tags {
    tags = {
      "Course"      = "RSSchool DevOps Course"
      "Task"        = "7. Monitoring Deployment on K8s"
      "ManagedBy"   = "Terraform"
      "CI"          = "GitHub Actions"
      "Date"        = "2025-07-26"
      "Project"     = "rs"
      "Environment" = "dev"
    }
  }
}

terraform {
  required_version = ">= 0.1"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.11, < 5.0"
    }
    null = {
      source  = "hashicorp/null"
      version = ">= 3.2"
    }
    archive = {
      source  = "hashicorp/archive"
      version = ">= 2.3"
    }
  }
}

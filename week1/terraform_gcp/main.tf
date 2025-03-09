terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.24.0"
    }
  }
}

# Key cloud provider Service
provider "google" {
  # Configuration options
  credentials = file(var.project_credentials)
  project     = var.project_id
  region      = var.region
}

# Deploy Google storage bucket service
resource "google_storage_bucket" "data-lake-bucket" {
  name     = var.GCP_Storage_bucket_name
  location = var.location

  # Optional, but recommended settings:
  storage_class               = "STANDARD"
  uniform_bucket_level_access = true
  force_destroy               = true

  versioning {
    enabled = true
  }

  lifecycle_rule {
    action {
      type = "AbortIncompleteMultipartUpload"
    }
    condition {
      age = 1 // days
    }
  }
}

# Deploy BigQuery Service
resource "google_bigquery_dataset" "demo_dataset" {
  dataset_id = var.BigQuery_dataset_name
  location   = var.location
}
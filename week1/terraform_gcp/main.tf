terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "6.24.0"
    }
  }
}

provider "google" {
  # Configuration options
    project     = "zoomcamp-2025-453112"
    region      = "europe-north1"
}

resource "google_storage_bucket" "data-lake-bucket" {
  name          = "zoomcamp-2025-453112-terra-bucket"
  location      = "US"

  # Optional, but recommended settings:
  storage_class = "STANDARD"
  uniform_bucket_level_access = true
  force_destroy = true  

  versioning {
    enabled = true
  }

  lifecycle_rule {
    action {
      type = "AbortIncompleteMultipartUpload"
    }
    condition {
      age = 1  // days
    }
  }
}
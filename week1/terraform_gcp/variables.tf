variable "project_id" {
  description = "My project ID"
  default     = "zoomcamp-2025-453112"
}

variable "project_credentials" {
  description = "project credential details"
  default     = "./keys/my_creds.json"
}

variable "region" {
  description = "project region"
  default     = "us-central1"
}

variable "location" {
  description = "project Location"
  default     = "US"
}

variable "GCP_Storage_bucket_name" {
  description = "Google storage bucket name"
  default     = "zoomcamp-2025-453112-terra-bucket"
}

variable "BigQuery_dataset_name" {
  description = "My Bigquery Dataset name"
  default     = "demo_dataset"
}
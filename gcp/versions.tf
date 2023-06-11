# This file defines the versions of the providers that will be used in the project.

terraform {
  required_providers {
    # GCP provider
    google = {
      source  = "hashicorp/google"
      version = "4.68.0"
    }
  }

  # State is stored in a GCS bucket.
  backend "gcs" {
    bucket = "terra-kion_terraform-backend"
    prefix = "terraform/state"
  }
}
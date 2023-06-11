# Purpose: This file is used to configure the provider for the GCP project.

# Configures the GCP provider.
provider "google" {
  project = var.project
  region  = var.region
  zone    = var.zone
}

# Enables the required APIs.
/* resource "google_project_service" "compute" {
  service = "compute.googleapis.com"
  disable_dependent_services=true
}

resource "google_project_service" "container" {
  service = "container.googleapis.com"
  disable_dependent_services=true
} */
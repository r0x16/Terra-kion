# Purpose: This file is used to configure the provider for the GCP project.

# Configures the GCP provider.
provider "google" {
  project = var.project
  region  = var.region
  zone    = var.zone
}

# Extracts the access token and cluster certificate from the GKE module.
data "google_client_config" "default" {}

# Configures the Kubernetes provider.
provider "kubernetes" {
  host                   = "https://${module.gke.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(module.gke.ca_certificate)
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
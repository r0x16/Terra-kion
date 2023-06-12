# This file creates a new private subnet for the GKE cluster in the default network.

# Gets the default network.
data "google_compute_network" "default" {
  name = "default"
}

# Creates a new private subnet for the GKE cluster in the default network.
# The subnet has 2 secondary IP ranges for pods and services.
resource "google_compute_subnetwork" "private" {
  name                     = "${var.project}-gke"
  ip_cidr_range            = var.subnet_cidr_range
  region                   = var.region
  network                  = data.google_compute_network.default.id
  private_ip_google_access = true

  secondary_ip_range {
    range_name    = "${var.project}-gke-pods"
    ip_cidr_range = var.ip_range_pods
  }
  secondary_ip_range {
    range_name    = "${var.project}-gke-services"
    ip_cidr_range = var.ip_range_services
  }
}

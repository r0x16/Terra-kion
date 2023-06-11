# Creates a new GKE cluster with a single node pool containing 3 nodes.
# The cluster is created in a private subnet with no public IP addresses.
module "gke" {
  source = "terraform-google-modules/kubernetes-engine/google"
  project_id = var.project
  name = "${var.project}-gke"
  region = var.region
  zones = var.zones
  network = "default"
  subnetwork = google_compute_subnetwork.private.name
  ip_range_pods = "${var.project}-gke-pods"
  ip_range_services = "${var.project}-gke-services"
  service_account = var.service_account
  
  node_pools = [
    {
      name = "${var.project}-gke-node-pool"
      max_count = 3
      initial_node_count = 3
    }
  ]
}

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

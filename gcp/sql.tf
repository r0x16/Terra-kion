# This file is used to create a PostgreSQL database in Cloud SQL.
#
# Creates:
# - Cloud SQL PostgreSQL database
# - Cloud SQL PostgreSQL user
# - Cloud SQL PostgreSQL instance (With private network only access)
#

module "pgsql" {
  source                      = "GoogleCloudPlatform/sql-db/google//modules/postgresql"
  version                     = "15.0.0"
  name                        = "${var.project}-pgsql"
  project_id                  = var.project
  region                      = var.region
  zone                        = var.zone
  database_version            = var.database_version
  db_name                     = var.project
  user_name                   = var.database_user
  deletion_protection         = false

  # Allow access to the database from the cluster default network
  ip_configuration = {
    ipv4_enabled        = false
    private_network     = data.google_compute_network.default.id
    require_ssl         = false
    allocated_ip_range  = null
    authorized_networks = []
  }
}

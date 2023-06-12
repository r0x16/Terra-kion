# This file defines the domain name using Cloud DNS
# Creates:
# - Cloud DNS zone
# - Cloud DNS record set
#
# Requires:
# - Published Kubernetes service
#

# Define the DNS zone
module "terra-kion-dns" {
  source     = "terraform-google-modules/cloud-dns/google"
  version    = "5.0"
  project_id = var.project
  type       = "public"
  name       = "terra-kion-cloud"
  domain     = "terra-kion.cloud."

  # Define the DNS record set
  recordsets = [
    {
      name    = ""
      type    = "A"
      ttl     = 300 # 5 minutes
      records = [kubernetes_service.terra-kion.status[0].load_balancer[0].ingress[0].ip]
    },
    {
      name    = "www"
      type    = "CNAME"
      ttl     = 300 # 5 minutes
      records = ["terra-kion.cloud."]
    }
  ]
}
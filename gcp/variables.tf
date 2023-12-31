# Purpose: Define variables for GCP resources

variable "project" {
  description = "The project to deploy resources."
  default     = "terra-kion"
}

variable "deploy_tag" {
  description = "The version to deploy in the service."
  default     = "latest"
}

variable "deploy_image" {
  description = "The image to deploy in the service."
  default     = "gcr.io/terra-kion/terra-kion"
}

variable "deploy_namespace" {
  description = "The namespace to deploy in the service."
  default     = "production"
}

variable "service_account" {
  description = "The service account to deploy resources."
  default     = "terra-kion@terra-kion.iam.gserviceaccount.com"
}

variable "region" {
  description = "The region which the provider will use."
  default     = "us-central1"
}

variable "zone" {
  description = "The zone to deploy resources."
  default     = "us-central1-a"
}

variable "zones" {
  description = "The zone to host the cluster."
  default     = ["us-central1-a"]
}

variable "subnet_cidr_range" {
  description = "The subnet CIDR to deploy resources."
  default     = "192.168.48.0/20"
}

variable "ip_range_pods" {
  description = "The IP range for GKE pods."
  default     = "172.20.0.0/16"
}

variable "ip_range_services" {
  description = "The IP range for GKE services."
  default     = "172.21.0.0/16"
}

variable "database_user" {
  description = "The database default username."
  default     = "r0x16"
}

variable "database_port" {
  description = "The database connection port."
  default     = "5432"
}

variable "database_version" {
  description = "The database version."
  default     = "POSTGRES_15"
}
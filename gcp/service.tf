# This file defines the service that will be deployed to the cluster
# Creates:
# - Kubernetes namespace
# - Kubernetes deployment
# - Kubernetes service
#
# Requires:
# - Kubernetes cluster provisioned

# Define the namespace
resource "kubernetes_namespace" "example" {
  metadata {
    name = "production"
  }
}

# Define the deployment
resource "kubernetes_deployment" "terra-kion" {
  metadata {
    name = "terra-kion"
    namespace = kubernetes_namespace.example.metadata[0].name
  }

  spec {
    replicas = 2
    selector {
      match_labels = {
        app = "terra-kion"
      }
    }
    template {
      metadata {
        labels = {
          app = "terra-kion"
        }
        namespace = kubernetes_namespace.example.metadata[0].name
      }
      spec {
        container {
          image = "gcr.io/terra-kion/terra-kion:latest"
          name  = "terra-kion"
          port {
            container_port = 8080
          }
          env {
            name  = "CRODONT_PORT"
            value = "8080"
          }
          resources {
            requests = {
              cpu    = "250m"
              memory = "512Mi"
            }
            limits = {
              cpu    = "500m"
              memory = "1024Mi"
            }
          }
          readiness_probe {
            http_get {
              path = "/"
              port = 8080
            }
            initial_delay_seconds = 50
            period_seconds        = 15
            timeout_seconds       = 5
          }
          liveness_probe {
            http_get {
              path = "/"
              port = 8080
            }
            initial_delay_seconds = 200
            period_seconds        = 60
            timeout_seconds       = 5
          }
        }
      }
    }
  }
}

# Define a Load Balanced service
resource "kubernetes_service" "terra-kion" {
  metadata {
    name = "terra-kion"
    namespace = kubernetes_namespace.example.metadata[0].name
  }

  spec {

    type = "LoadBalancer"

    selector = kubernetes_deployment.terra-kion.spec[0].selector[0].match_labels

    port {
      port        = 80
      target_port = kubernetes_deployment.terra-kion.spec[0].template[0].spec[0].container[0].port[0].container_port
      protocol    = "TCP"
    }
  }
}

output "public_ip" {
  value = kubernetes_service.terra-kion.status[0].load_balancer[0].ingress[0].ip
}
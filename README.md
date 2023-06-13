# 🌐 Terra-kion

You can read this documentation in Spanish by clicking the following [link](./README_es.md).

Terra-kion is an innovative web application created to demonstrate the practical use of cutting-edge development tools. This application has been developed using Go, Terraform, Ansible, GitHub Actions, the Echo framework for Go, and Gorm for database access.

## ⚙️ Features

Upon entering Terra-kion, a random string is generated and stored in the database. Subsequently, the site shows you the last 10 records in JSON format, emulating a real-time backend.

## 🔄 Continuous Deployment

The essence of the project is to demonstrate the process of continuous deployment. Upon generating a new release of the application on GitHub, it automatically prepares a Docker image using GitHub Actions, which is uploaded to the Google Cloud image repository.

Subsequently, the site is deployed on Google Cloud Platform using Ansible and Terraform.

### 🚀 Deployment Process

1. Ansible scripts connect to the GCP account and publish the Docker image in the Google Container Registry with the name `gcr.io/terra-kion/terra-kion`, assigning it the `latest` tags and the release name (e.g., `v1.0.0`).
2. Then, Terraform scripts run to create and deploy the infrastructure as follows:
   - Create the necessary networks for the project (using the default network, but creating specific subnets for the cluster).
   - Create a 3-node Kubernetes cluster (GKE).
   - Create a Postgres database instance in Cloud SQL.
   - Create a Kubernetes service using a load balancer.
   - Create a deployment of the application with 2 replicas, all in a namespace called `production`.
   - Create a domain called `terra-kion.cloud` (with an associated CNAME subdomain `www`).

## 🌐 Website

To verify the deployment of the application, you can visit the website at [www.terra-kion.cloud](http://www.terra-kion.cloud).

### 📍 Endpoints

The web application has two endpoints:

- `/` : This is the main endpoint that displays the records stored in the database.
- `/health` : This endpoint is used by the orchestrator to check the health status of the site, returning "OK" in plain text.

## 📝 License

The project does not have any associated license. It was fully developed by me, with a lot of love, to improve my skills in CI/CD. The project is open source and all suggestions are welcome.


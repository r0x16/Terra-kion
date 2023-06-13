# 🌍 Terra-kion

Terra-kion es una aplicación web innovadora creada para demostrar el uso práctico de herramientas de desarrollo de vanguardia. Esta aplicación ha sido desarrollada utilizando Go, Terraform, Ansible, GitHub Actions, el framework Echo para Go y Gorm para acceder a la base de datos.

## ⚙️ Funcionalidades

Al ingresar a Terra-kion, se genera una cadena aleatoria que se almacena en la base de datos. Posteriormente, el sitio te muestra los últimos 10 registros en formato JSON, emulando un backend en tiempo real.

## 🔄 Despliegue Continuo

La esencia del proyecto es demostrar el proceso de despliegue continuo. Al generar una nueva release de la aplicación en GitHub, esta automáticamente prepara una imagen de Docker usando GitHub Actions, la cual se sube al repositorio de imágenes de Google Cloud.

Posteriormente, el sitio es desplegado en Google Cloud Platform utilizando Ansible y Terraform.

### 🚀 Proceso de Despliegue

1. Los scripts de Ansible se conectan a la cuenta de GCP y publican la imagen de Docker en el Container Registry de Google con el nombre `gcr.io/terra-kion/terra-kion`, asignándole las tags `latest` y el nombre del release (p.ej., `v1.0.0`).
2. Luego, los scripts de Terraform se ejecutan para crear y desplegar la infraestructura de la siguiente manera:
   - Crean las redes necesarias para el proyecto (utilizando la red default, pero creando subredes específicas para el clúster).
   - Crean un clúster de Kubernetes de 3 nodos (GKE).
   - Crean una instancia de base de datos Postgres en Cloud SQL.
   - Crean un servicio de Kubernetes usando un balanceador de carga.
   - Crean un despliegue de la aplicación con 2 réplicas, todo en un namespace llamado `production`.
   - Crean un dominio llamado `terra-kion.cloud` (con un subdominio CNAME `www` asociado).

## 🌐 Sitio Web

Para verificar el despliegue de la aplicación, puedes visitar el sitio web en [www.terra-kion.cloud](http://www.terra-kion.cloud).

### 📍 Endpoints

La aplicación web tiene dos endpoints:

- `/` : Este es el endpoint principal que muestra los registros almacenados en la base de datos.
- `/health` : Este endpoint es utilizado por el orquestador para verificar el estado de salud del sitio, retornando "OK" en texto plano.

## 📝 Licencia

El proyecto no tiene ninguna licencia asociada. Fue desarrollado íntegramente por mí, con mucho cariño, para mejorar mis habilidades en CI/CD. El proyecto es de código abierto y todas las sugerencias son bienvenidas.


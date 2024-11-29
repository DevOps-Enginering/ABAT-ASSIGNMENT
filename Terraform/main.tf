resource "null_resource" "minikube_cluster" {
  provisioner "local-exec" {
    command = "minikube start"
  }
}

resource "null_resource" "minikube_addons" {
  depends_on = [null_resource.minikube_cluster]
  provisioner "local-exec" {
    command = <<-EOT
      minikube addons enable ingress
      minikube addons enable ingress-dns
    EOT
  }
}

resource "kubernetes_namespace" "dev" {
  depends_on = [null_resource.minikube_addons]
  metadata {
    name = "dev"
  }
}

resource "kubernetes_namespace" "prod" {
  depends_on = [null_resource.minikube_addons]
  metadata {
    name = "prod"
  }
}
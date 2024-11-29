resource "null_resource" "minikube_cluster" {
  provisioner "local-exec" {
    command = "minikube start --vm=true --driver=docker"
  }
}

resource "kubernetes_namespace" "dev" {
  depends_on = [null_resource.minikube_cluster]
  metadata {
    name = "dev-namespace"
  }
}
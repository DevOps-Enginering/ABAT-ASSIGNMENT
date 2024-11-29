resource "null_resource" "minikube_cluster" {
  provisioner "local-exec" {
    command = "minikube start"
  }
}

resource "null_resource" "minikube_addons" {
  depends_on = [null_resource.minikube_cluster]
  
  for_each = toset(var.minikube_addons)
  
  provisioner "local-exec" {
    command = "minikube addons enable ${each.key}"
  }
}

resource "kubernetes_namespace" "namespaces" {
  depends_on = [null_resource.minikube_addons]
  
  for_each = toset(var.namespaces)
  
  metadata {
    name = each.key
  }
}
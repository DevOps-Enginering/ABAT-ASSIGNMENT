variable "namespaces" {
  description = "List of namespaces to create"
  type        = list(string)
}

variable "minikube_addons" {
  description = "List of Minikube addons to enable"
  type        = list(string)
}
// https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs
provider "kubernetes" {
  config_context_cluster   = "minikube"
  config_path              = "~/.kube/config"
}

// https://registry.terraform.io/providers/hashicorp/helm/latest/docs
provider "helm" {
  kubernetes {
	config_context_cluster   = "minikube"
    config_path              = "~/.kube/config"
  }
}

kubectl -n demo-2 port-forward svc/keycloak-http 8080:80
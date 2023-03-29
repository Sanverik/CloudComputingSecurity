// https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/
// https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace
resource "kubernetes_namespace" "keycloak" {
  metadata {
	name = "demo-2"
  }
}

// https://github.com/codecentric/helm-charts/tree/master/charts/keycloak
// https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release
resource "helm_release" "keycloak" {
  name       = "keycloak"
  repository = "https://codecentric.github.io/helm-charts"
  chart      = "keycloak"
  namespace  = kubernetes_namespace.keycloak.metadata[0].name
  version    = "18.4.0"

  // https://github.com/codecentric/helm-charts/blob/master/charts/keycloak/values.yaml

    set {
    name  = "image.tag"
    value = "19.0.1-legacy"
  }


  depends_on = [kubernetes_namespace.keycloak]
}
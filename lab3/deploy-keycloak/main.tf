// https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/
// https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace
resource "kubernetes_namespace" "keycloak" {
  metadata {
	name = "keycloak"
  }
}

// https://bitnami.com/stack/keycloak/helm
// https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release
resource "helm_release" "keycloak" {
  name       = "keycloak"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "keycloak"
  namespace  = kubernetes_namespace.keycloak.metadata[0].name
  version    = "13.1.3"

  // https://github.com/bitnami/charts/blob/main/bitnami/keycloak/values.yaml
  set {
    name  = "auth.adminUser"
    value = "admin"
  }

  set {
    name  = "auth.adminPassword"
    value = "admin"
  }

  set {
    name  = "httpRelativePath"
    value = "/auth/"
  }

  set {
    name  = "global.storageClass"
    value = "standard"
  }

  set {
    name  = "readinessProbe.initialDelaySeconds"
    value = 120
  }


  depends_on = [kubernetes_namespace.keycloak]
}
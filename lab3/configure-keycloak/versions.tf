terraform {
  required_version = "1.2.4"
  required_providers {
    keycloak = {
      source = "mrparkers/keycloak"
      version = "4.2.0"
    }
  }
}
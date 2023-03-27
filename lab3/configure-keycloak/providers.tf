// https://registry.terraform.io/providers/mrparkers/keycloak/latest/docs
// https://registry.terraform.io/providers/mrparkers/keycloak/latest/docs
provider "keycloak" {
  url       = "http://localhost:8080/auth"
  client_id = "admin-cli"
  realm    = "master"
  username = "admin"
  password = "admin"
}
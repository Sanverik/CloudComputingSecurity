// https://registry.terraform.io/providers/mrparkers/keycloak/latest/docs/resources/realm
resource "keycloak_realm" "test_realm" {
  realm   = "test-realm"
  enabled = true
}

// https://registry.terraform.io/providers/mrparkers/keycloak/latest/docs/resources/openid_client
resource "keycloak_openid_client" "test_client" {
  realm_id      = keycloak_realm.test_realm.id
  client_id     = "test-client"
  name          = "Test Client"
  access_type   = "CONFIDENTIAL"
  client_secret = "1234567890secret"
  direct_access_grants_enabled = true
  service_accounts_enabled     = true
}

// https://registry.terraform.io/providers/mrparkers/keycloak/latest/docs/resources/user
resource "keycloak_user" "test_user" {
  realm_id  = keycloak_realm.test_realm.id
  username  = "test-user"
  email     = "testuser@example.com"
  first_name = "Test"
  last_name = "User"
  enabled   = true

  // http://localhost:8080/auth/realms/test-realm/account
  initial_password {
    value     = "123SECURE@"
    temporary = true
  }
}
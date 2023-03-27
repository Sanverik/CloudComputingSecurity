resource "keycloak_realm" "realm" {
  realm   = "my-realm"
  enabled = true
}

resource "keycloak_openid_client" "openid_client" {
  realm_id            = keycloak_realm.realm.id
  client_id           = "test-client"

  name                = "test client"
  enabled             = true

  access_type         = "CONFIDENTIAL"

  login_theme = "keycloak"

  extra_config = {
    "key1" = "value1"
    "key2" = "value2"
  }
}

data "template_file" "client_credentials_request" {
  template = jsonencode({
    client_id     = "test-client"
    client_secret = "4uNgYgJGaPuYNeut1BzVinUoLXZrqjLQ"
    grant_type    = "client_credentials"
  })
}

data "http" "client_credentials_token" {
  method = "POST"
  url    = "http://localhost:8080/realms/my-realm/protocol/openid-connect/token"

  request_headers  = {
    "Content-Type" = "application/x-www-form-urlencoded"
  }
}

output "access_token" {
  value = data.http.client_credentials_token.body
}
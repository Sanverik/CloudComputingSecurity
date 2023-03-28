output "test_client_id" {
  value = keycloak_openid_client.test_client.client_id
}

output "test_client_secret" {
  value = nonsensitive(keycloak_openid_client.test_client.client_secret)
}

output "test_user_id" {
  value = keycloak_user.test_user.id
}
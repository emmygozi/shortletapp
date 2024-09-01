# # Retrieve the latest version of the secret
# data "google_secret_manager_secret_version" "my_secret" {
#   secret = "shortlet"
# }

# # Use the secret's value
# output "my_secret_value" {
#   value = data.google_secret_manager_secret_version.my_secret.secret_data
# }

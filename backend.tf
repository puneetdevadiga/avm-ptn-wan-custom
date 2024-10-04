data "terraform_remote_state" "avm-ptn-wan-custom" {
  backend = "local" # Change as per your backend configuration
  config = {
    path = "/c/Users/pdevadiga/applications/avm-ptn-wan-custom/terraform.tfstate" # This should point to the saved vWAN state file
  }
}
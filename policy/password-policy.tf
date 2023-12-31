provider "aws" {
  region = "us-east-1"
  profile= "default"
}

resource "aws_iam_account_password_policy" "Password-Policy" {
  hard_expiry = false
  allow_users_to_change_password = true
  max_password_age = 90
  minimum_password_length = 14
  password_reuse_prevention = 24
  require_lowercase_characters = true
  require_numbers = true
  require_symbols = true
  require_uppercase_characters = true
}
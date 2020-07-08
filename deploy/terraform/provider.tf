provider "aws" {
  version = "~> 2.0"
  profile                 = "my-profile-name"
  shared_credentials_file = "/Users/masatoyamashita/.aws/credentials"
  region = "ap-northeast-1"
}
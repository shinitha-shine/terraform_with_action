terraform {
  backend "s3" {
    bucket = "master.shinithavargheese.online"
    key    = "terraform.tfstate"
  }
}

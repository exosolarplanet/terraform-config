terraform {
  cloud {
    organization = "my-company-ece"
    workspaces {
      name = "rev-dev-project"
    }
  }
}

terraform {
  cloud {
    organization = "my-company-ece"
    workspaces {
      name = "rev-dev-project"
    }
  }
}

provider "google" {
    project = var.project_id
}

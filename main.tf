terraform {
  cloud {
    organization = "my-company-ece"
    workspaces {
      name = "terraform-config"
    }
  }
}

provider "google" {
    project = var.project_id
}

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

resource "google_app_engine_application" "app" {
  project     = var.project_id
  location_id = "europe-west"
}

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

resource "google_sql_database_instance" "main" {
  name             = "main-instance"
  database_version = "POSTGRES_14"
  region           = "europe-west3"

  settings {
    tier = "db-f1-micro"
  }
}

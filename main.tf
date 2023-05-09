terraform {
  cloud {
    organization = "my-company-ece"
    workspaces {
      name = "bornin-terraform-config"
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
    
    database_flags {
      name  = "cloudsql.iam_authentication"
      value = "on"
    }
  }
}

data "google_app_engine_default_service_account" "default" {
}

resource "google_project_iam_binding" "project" {
  project = var.project_id
  role    = "roles/cloudsql.instanceUser"

  members = [
    "serviceAccount:data.google_app_engine_default_service_account.default.email",
  ]
}

resource "google_sql_user" "users" {
  name     = data.google_app_engine_default_service_account.default.email
  instance = google_sql_database_instance.main.name
  type     = "CLOUD_IAM_USER"
}

terraform {
  cloud {
    organization = "my-company-ece"
    workspaces {
      name = "bornin-tf-workspace"
    }
  }
}

provider "google-beta" {
    project = var.project_id
}

resource "google_app_engine_application" "app" {
  provider = google-beta

  project     = var.project_id
  location_id = "europe-west3"
}

data "google_app_engine_default_service_account" "default" {
}

resource "google_service_account_iam_binding" "admin-account-iam" {
  provider = google-beta

  service_account_id = data.google_app_engine_default_service_account.default.name
  role               = "roles/cloudsql.client"

  members = [
    "serviceAccount:${data.google_app_engine_default_service_account.default.email}",
  ]
}

resource "google_compute_network" "private_network" {
  provider = google-beta

  name = "private-network"
}

resource "google_compute_global_address" "private_ip_address" {
  provider = google-beta

  name          = "private-ip-address"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = google_compute_network.private_network.id
}

resource "google_service_networking_connection" "private_vpc_connection" {
  provider = google-beta

  network                 = google_compute_network.private_network.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]
}


resource "google_sql_database_instance" "bornin_db_instance" {
  provider = google-beta

  name             = "bornin-db_instance"
  database_version = "MYSQL_8_0"
  region           = "europe-west3"
  deletion_protection = false

  depends_on = [google_service_networking_connection.private_vpc_connection]
  settings {
    tier = "db-f1-micro"
    ip_configuration {
      ipv4_enabled                                  = false
      private_network                               = google_compute_network.private_network.id
      enable_private_path_for_google_cloud_services = true
    }
  }
}

resource "google_sql_database" "bornin_database" {
  provider = google-beta

  name     = "bornin_database"
  instance = google_sql_database_instance.bornin_db_instance.name
}

resource "random_id" "db_pass" {
  byte_length = 4
}

resource "google_sql_user" "users" {
  provider = google-beta

  name     = "guest"
  instance = google_sql_database_instance.bornin_db_instance.name
  password = random_id.db_pass.hex
  
}

resource "google_vpc_access_connector" "bornin_connector" {
  provider = google-beta

  name          = "bornin_connector"
  ip_cidr_range = "10.8.0.0/28"
  network       = google_compute_network.private_network.id
  region        = "europe-west3"
}
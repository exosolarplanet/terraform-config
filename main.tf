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
    impersonate_service_account = "tf-bornin-project-sa@bornin-project.iam.gserviceaccount.com"

}

resource "google_app_engine_application" "app" {
  project     = var.project_id
  location_id = "europe-west"
}

terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "6.27.0"
    }
  }
}

provider "google" {
  region = "us-central1"
  project = var.project
}

resource "google_service_account" "airflow" {
  account_id   = var.account_id
  display_name = var.display_name
  project = var.project
}


resource "google_project_iam_member" "airflow" {
  project = var.project
  role    = "roles/${var.airflow_role}"
  member  = "serviceAccount:${google_service_account.airflow.email}"
}

resource "google_service_account_key" "airflow" {
  service_account_id = google_service_account.airflow.name
  private_key_type    = var.private_key_type
}

resource "local_file" "private_key_file" {
  content  = google_service_account_key.airflow.private_key
  filename = var.private_key_path
}

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.5.0"
    }
  }
}

provider "google" {
  credentials = file("gcp-credentials-scollynz-rare-palace-329321.json")

  project = "rare-palace-329321"
  region  = "australia-southeast"
  zone    = "australia-southeast2"
}

resource "google_compute_subnetwork" "caravan-australia" {
  name          = "caravan-australia"
  ip_cidr_range = "10.2.0.0/16"
  region        = "australia-southeast2"
  network       = google_compute_network.vpc_network.id
}

resource "google_compute_network" "vpc_network" {
  name                    = "terraform-network"
  auto_create_subnetworks = false
}
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.5.0"
    }
  }
}

provider "google" {
  credentials = file("scollynz-rare-palace-329321-gcp-credentials.json")

  project = "rare-palace-329321"
  region  = "australia-southeast"
  zone    = "australia-southeast2"
}

resource "google_compute_subnetwork" "caravan-australia" {
  name          = "caravan-australia"
  ip_cidr_range = "10.2.0.0/16"
  region        = "australia-southeast2"
  network       = google_compute_network.vpc-network.id
}

resource "google_pubsub_topic" "caravan_solar_telemetry" {
  name = "caravan_solar_telemetry"
}

resource "google_compute_network" "vpc-network" {
  name                    = "vpc-network"
  auto_create_subnetworks = false
}

resource "google_cloudiot_registry" "solar_device_registry" {
  name   = "solar_device_registry"
  region = "asia-east1"

  event_notification_configs {
    pubsub_topic_name = google_pubsub_topic.caravan_solar_telemetry.id
    subfolder_matches = ""
  }
}
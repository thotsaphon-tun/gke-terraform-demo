terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "~> 7.17"
    }
  }
}

provider "google" {
  project     = "gke-test-486202"
  region      = "ap-southeast1"
}
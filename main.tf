variable "project" {
  type    = "string"
}

variable "region" {
  type    = "string"
  default = "us-central1"
}

variable "zone" {
  type    = "string"
  default = "us-central1-c"
}

provider "google" {
  project = "${var.project}"
  region  = "${var.region}"
  zone    = "${var.zone}"
}

resource "google_service_account" "vault" {
  account_id   = "hashicorp-vault"
  display_name = "Hashicorp Vault"
}

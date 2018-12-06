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

resource "google_storage_bucket" "vault" {
  name          = "${var.project}-vault"
  force_destroy = true
  location      = "${var.region}"
  storage_class = "REGIONAL"
}

resource "google_storage_bucket_acl" "vault" {
  bucket      = "${google_storage_bucket.vault.name}"
  default_acl = "projectPrivate"
}

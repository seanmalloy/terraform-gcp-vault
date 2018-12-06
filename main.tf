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

resource "google_kms_key_ring" "vault" {
  name     = "vault-keyring"
  location = "us-central1"

  lifecycle {
    prevent_destroy = true
  }
}

resource "google_kms_crypto_key" "vault" {
  name            = "vault-key"
  key_ring        = "${google_kms_key_ring.vault.self_link}"

  lifecycle {
    prevent_destroy = true
  }
}

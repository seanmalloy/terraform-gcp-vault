# Deploy Hashicorp Vault in GCP

Set environment variables before running terraform.
```
export GOOGLE_CLOUD_KEYFILE_JSON=/path/gcp_key.json
```

Run it.
```
$ terraform init
$ terraform apply -var 'project=myproject'
```

# GCP Set Up

```bash
# Set environment variable to point to your downloaded GCP keys:

export GOOGLE_APPLICATION_CREDENTIALS="<path/to/your/service-account-authkeys>.json"
  

# Refresh token/session, and verify authentication

gcloud auth application-default login`
```
# Terraform Set up

```bash
# Initialize state file (.tfstate)
terraform init

# Updates the Terraform state file (.tfstate) with the current state of your infrastructure
terraform refresh

# Creates an execution plan that shows what changes Terraform will make to your infrastructure.
terraform plan -var="project=<your-gcp-project-id>"

# Create new infra
terraform apply -var="project=<your-gcp-project-id>"

# Delete infra after your work, to avoid costs on any running services
terraform destroy
```






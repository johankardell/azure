tf-init:
	rm -rf .terraform
	az account set -s "${AZURE_LAB_SUBSCRIPTION}"
	terraform init

tf-clean:
	rm -rf .terraform
	rm terraform.tfstate
	rm terraform.tfstate.*

tf-plan:
	az account set -s "${AZURE_LAB_SUBSCRIPTION}"
	terraform fmt
	terraform plan

tf-apply:
	az account set -s "${AZURE_LAB_SUBSCRIPTION}"
	terraform fmt
	terraform apply

tf-apply-force:
	az account set -s "${AZURE_LAB_SUBSCRIPTION}"
	terraform fmt
	terraform apply -auto-approve

tf-destroy:
	az account set -s "${AZURE_LAB_SUBSCRIPTION}"
	terraform destroy

tf-destroy-force:
	az account set -s "${AZURE_LAB_SUBSCRIPTION}"
	terraform destroy -auto-approve
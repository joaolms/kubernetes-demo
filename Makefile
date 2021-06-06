.DEFAULT_GOAL := help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

tf-init: ## Inicializar o projetos Terraform
	terraform init --upgrade=true

tf-validate: tf-init ## Inicializar e validar o projeto Terraform
	terraform validate

tf-plan: tf-init ## Executar o plan do Terraform para verificar as modificações que serão realizadas
	terraform plan --out plano.tfplan

tf-apply: ## Aplicar as modificações indicadas no plano
	terraform apply "plano.tfplan"

inicializar-cluster: ## Executar o provisionamento do cluster com roles do Ansible
	ansible-playbook -i hosts k8s-playbook.yml

tf-destroy: ## Destruir o ambiente provisionado
	terraform destroy --auto-approve

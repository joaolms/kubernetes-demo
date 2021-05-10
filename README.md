# Kubernetes
## Descrição
Construção de um cluster Kubernetes

**Ambiente:**
- Microsoft Azure
  - 1 Virtual Network
  - Cluster Kubernetes
    - 1 master
    - 2 workers

## Instruções de configuração do ambiente
Utilizei o Microsoft Azure para os servidores, portanto é necessário uma conta no Azure e a criação de um Service Principal (SP) para conectar no Azure e provisionar os servidores.
A [documentação oficial](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/service_principal_client_secret) da Microsoft para criar o SP.

Aqui deixo um resumo para facilitar a criação do SP
```bash
export ARM_SUBSCRIPTION_ID="SUA_SUBSCRIÇÃO"

az ad sp create-for-rbac --name "k8s-sp" --role="Contributor" --scope="/subscriptions/${ARM_SUBSCRIPTION_ID}"
```

Esse comando retornará os dados que precisamos configurar como variável de ambiente.

```bash
export ARM_CLIENT_ID="00000000-0000-0000-0000-000000000000"
export ARM_CLIENT_SECRET="00000000-0000-0000-0000-000000000000"
export ARM_SUBSCRIPTION_ID="00000000-0000-0000-0000-000000000000"
export ARM_TENANT_ID="00000000-0000-0000-0000-000000000000"
```

## Provisionamento Infraestrutura Azure
O Terraform cria os seguintes recursos na conta do Azure:
- 1 Resource Group
- 1 Rede Virtual
- 3 Máquinas Virtuais
- 3 IPs Públicos

O primeiro passo é criar o arquivo ```terraform.tfvars``` com base no arquivo ```terraform.tfvars.example``` e adicionar à variável **ssh_pubkey** sua chave pública de conexão SSH para ser utilizada para conexão aos servidores.

Agora adicione sua chave privada ao ssh-agent:
```bash
ssh-add SUA_CHAVE.pem
```

Criei um Makefile para facilitar e padronizar a execução dos scripts do Terraform, utilize os comandos abaixo para iniciar criar a infraestrutura no Azure.
```bash
make tf-plan
make tf-apply
```

## Provisionamento Cluster Kubernetes
Adicione os IP's dos servidores ao arquivo ```hosts```, que é o arquivo de inventário do Ansible e execute o playbook Ansible para provisionamento do Cluster.

```bash
make inicializar-cluster
```

## TO-DO
- Volume persistente
- Ingress Controller
- Deploy de uma aplicação de exemplo
- Configurar Github Actions
- Adicionar idempotência ao playbook de provisionamento do cluster
- Adicionar um diagrama da infraestrutura para facilitar o entendimento do projeto
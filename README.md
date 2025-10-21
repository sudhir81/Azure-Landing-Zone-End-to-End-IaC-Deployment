
# 🚀 Azure Landing Zone – End-to-End IaC Deployment (WIP)

This repository provisions a **Minimum Viable Landing Zone (MVLZ)** on Azure using **Terraform**, then layers **governance (Policy)** and **access control (RBAC)**.

## 🧩 What this deploys
- 🌐 **Hub-Spoke VNets** with peering
- 🔥 **Azure Firewall** in Hub + default route from Spoke
- 🧱 **NSGs** and **UDRs**
- 📊 **Log Analytics Workspace** (centralized diagnostics)
- 🛡️ **Azure Policy** (tag enforcement, deny public IP on NICs, audit diagnostics)
- 👥 **RBAC** on Hub/Spoke resource groups

## 📦 Remote State (Azure Storage)
```
resource_group_name  = "rg-landingzone-tfstate"
storage_account_name = "stlztf2131"
container_name       = "tfstate"
key                  = "landingzone/terraform.tfstate"
```
Configure backend at init:
```bash
terraform init -backend-config=backend.hcl
```

## ▶️ How to deploy
```bash
az login
az account set --subscription "....................."

terraform init -backend-config=backend.hcl
terraform validate
terraform plan -out plan.tfplan
terraform apply plan.tfplan
```

## 🧰 CI/CD
GitHub Actions workflow runs `fmt`, `validate`, and `plan` on PRs and pushes to `main`. Add `AZURE_CREDENTIALS` repository secret (Service Principal JSON).

## 🗺️ Structure
```
modules/
  hub/      -> Hub VNet, Firewall, diagnostics
  spoke/    -> Spoke VNet, peering, NSGs, UDRs
  monitor/  -> Log Analytics workspace
  policy/   -> Policy assignments
  rbac/     -> Role assignments
```

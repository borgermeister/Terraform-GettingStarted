# Terraform Getting Started

## Requirements

### Login to Azure CLI and get SubscriptionID
```
az login --tenant <tenant>
az account show --query id
```
### Create Azure AD Service Principal
```
Multiple lines in terminal are separated with “\”
In Windows multiple lines are separated with “^”
```
```
az ad sp create-for-rbac \
  --name="Terraform Service Principal" \
  --role="Contributor" \
  --scopes="/subscriptions/<subscriptionId>"
```
### Create environment variables that Terraform will use
```
export ARM_TENANT_ID=xx-xx-xx-xx-xx
export ARM_SUBSCRIPTION_ID=xx-xx-xx-xx-xx
export ARM_CLIENT_ID=xx-xx-xx-xx-xx
export ARM_CLIENT_SECRET=xxx
```
### Virtual Machine Module requirements
Create an SSH keypair named 'terraform' and place 'terraform.pub' in the ssh_keys subfolder of the repository. Remember to keep the private key away from the repository.
```
ssh-keygen -t ed25519 -f ~/.ssh/terraform -C <key_comment>
cp ~/.ssh/terraform.pub ./ssh_keys/
```
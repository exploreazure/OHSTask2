# Deploy Task 2 Resources

The deploy.bicep file will deploy the following resources

* Function App Resource Group
* App Service Plan
* Function App

## Parameters

**Required Parameters**

Parameter Name: location
Type: string
Description: Deployment Region (for example UKSOUTH)

Parameter Name: faResourceGroup
Type: string
Description: Function App resource group name


Parameter Name: aspName
Type: string
Description: App Service Plan Name


Parameter Name: faName
Type: string
Description: Function App Name

## Azure CLI

```
az login

az account show

// If wrong sub then run

az account set --subscription "<subid>"

az deployment sub create --location uksouth --template-file "deploy.bicep"

```
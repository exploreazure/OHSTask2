# Deploy Task 2 Resources

The deploy.bicep file will deploy the following resources

* Function App Resource Group
* App Service Plan
* Function App
* CosmosDB SQL acccount
* CosmosDB SQL database and container, with key
* CosmosDB configured with serverless, read and write locations

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

Parameter Name: cdbResourceGroupName
Type: string
Description: CosmosDB resource group name

Parameter Name: cdbName
Type: string
Description: CosmosDB account name

Parameter Name: sqlcontainername
Type: string
Description: CosmosDB SQL container name

## Azure CLI

```
az login

az account show

// If wrong sub then run

az account set --subscription "<subid>"

Example:

az deployment sub create --location uksouth --template-file 
"deploy.bicep" --parameters faResourceGroup="rg-fa-iactest" aspName="aspohsiactest" faName="fnohsiactest01" location="uksouth" cdbResourceGroup="rg-db-iactest" cdbName="iacohscdbsql03" sqlcontainername="productcontainer"

```
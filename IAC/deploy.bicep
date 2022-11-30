// ================ //
// Parameters       //
// ================ //
@description('Required. The deployment location')
param location string
@description('Function App resource group')
param faResourceGroup string
@description('app service plan name')
param aspName string
@description('FunctionApp name')
param faName string

targetScope = 'subscription'

module faResourceGroups './modules/Microsoft.Resources/resourceGroups/deploy.bicep' = {
  name: faResourceGroup
  params: {
    // Required parameters
    name: faResourceGroup
    location: location
    // Non-required parameters
  }
}

module appServicePlan './modules/Microsoft.Web/serverfarms/deploy.bicep' = {
  // deploy app service plan
  name: aspName
  scope: resourceGroup(faResourceGroup)
  params: {
    // Required parameters
    name: aspName
    location: location
    sku: {
      name: 'Y1'
      tier: 'Dynamic'
    }
  }
}

module sites './modules/Microsoft.Web/sites/deploy.bicep' = {
  name: faName
  scope: resourceGroup(faResourceGroup)
  params: {
    // Required parameters
    kind: 'functionapp'
    location: location
    name: faName
    serverFarmResourceId: appServicePlan.outputs.resourceId
    // Non-required parameters
  }
}


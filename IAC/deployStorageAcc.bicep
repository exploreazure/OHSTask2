// ================ //
// Parameters       //
// ================ //
@description('Required. Location')
param location string
@description('Storage account resource group name')
param saResourceGroupName string
@description('Storage acccount name')
param saName string

targetScope = 'subscription'

module saResourceGroups './modules/Microsoft.Resources/resourceGroups/deploy.bicep' = {
  name: saResourceGroupName
  params: {
    // Required parameters
    name: saResourceGroupName
    location: location
    // Non-required parameters
  }
}

module storageAccounts './modules/Microsoft.Storage/storageAccounts/deploy.bicep' = {
  name: saName
  scope: resourceGroup(saResourceGroupName)
  params: {
    // Required parameters
    location: location
    name: saName
    // Non-required parameters
    allowBlobPublicAccess: false
  }
}

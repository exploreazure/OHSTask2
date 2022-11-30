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
@description('CosmosDB resource group name')
param cdbResourceGroup string
@description('CosmosDB name')
param cdbName string
@description('CosmosDB Container name')
param sqlcontainername string

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

module cdbResourceGroups './modules/Microsoft.Resources/resourceGroups/deploy.bicep' = {
  name: cdbResourceGroup
  params: {
    // Required parameters
    name: cdbResourceGroup
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

module databaseAccounts './modules/Microsoft.DocumentDB/databaseAccounts/deploy.bicep' = {
  name: cdbName
  scope: resourceGroup(cdbResourceGroup)
  params: {
    // Required parameters
    location: location
    locations: [
      {
        failoverPriority: 0
        isZoneRedundant: false
        locationName: location
      }
    ]
    name: cdbName
    // Non-required parameters
    capabilitiesToAdd: ['EnableServerless']
    defaultConsistencyLevel: 'Session'
    sqlDatabases: [
      {
        containers: [
          {
            kind: 'Hash'
            name: sqlcontainername
            paths: [
              '/productKey'
            ]
          }
        ]
        name: sqlcontainername
      }
    ]

  }
}


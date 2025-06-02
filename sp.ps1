# Define variables
$spName = "sp-github-actions-workshop"
$subscriptionId = ""
$scope = "/subscriptions/$subscriptionId/resourceGroups/rg-github-actions-workshop"

# Create the service principal
$sp = az ad sp create-for-rbac `
    --name $spName `
    --role contributor `
    --scopes $scope `
    --years 1 `
    | ConvertFrom-Json

# Format the output as GitHub Actions secret JSON
$githubSecret = @{
    clientId                   = $sp.appId
    clientSecret               = $sp.password
    subscriptionId             = $subscriptionId
    tenantId                   = $sp.tenant
    activeDirectoryEndpointUrl = "https://login.microsoftonline.com"
    resourceManagerEndpointUrl = "https://management.azure.com/"
    authorityHost              = "https://login.microsoftonline.com"
    azureCloud                 = "AzureCloud"
} | ConvertTo-Json -Depth 3

# Output the JSON (you'll copy this into GitHub secret)
Write-Output $githubSecret

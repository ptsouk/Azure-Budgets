$subscriptionId = ""
Set-AzContext -SubscriptionId $subscriptionId
$resourceGroupName = ""
$budgetName = $resourceGroupName + "_budget"
$amount = 100
$startDate = (Get-Date -Day 1).ToString("yyyy-MM-dd")
$endDate = (Get-Date -Day 1).AddYears(1).ToString("yyyy-MM-dd")
$contactEmails = "", ""

New-AzResourceGroupDeployment -Name "deploy-budget" `
    -ResourceGroupName $resourceGroupName `
    -TemplateFile .\budget-resourcegroup-template.json `
    -budgetName $budgetName `
    -amount $amount `
    -startDate $startDate `
    -endDate $endDate `
    -contactEmails $contactEmails `
    -DeploymentDebugLogLevel All `
    -Verbose

#verify 
(Get-AzConsumptionBudget -Name $budgetName).Notification.Keys | ForEach-Object {$notifications[$_]}
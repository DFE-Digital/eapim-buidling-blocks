Param(
[string] $apiManagementRg,
[string] $apiManagementName,
[string] $IRISProductID,
[string] $IRISProductName,
[bool] $ApprovalRequired=$True,
[bool] $SubscriptionRequired=$True
)
$DebugPreference="Continue"

$ApiMgmtContext = New-AzureRmApiManagementContext -ResourceGroupName "$apiManagementRg" -ServiceName "$apiManagementName" 

$product = Get-AzureRmApiManagementProduct -Context $ApiMgmtContext -ProductId $IRISProductID -ErrorAction Continue

if (!$product){
New-AzureRmApiManagementProduct -Context $ApiMgmtContext -ProductId "$IRISProductID" -Title "$IRISProductName" -Description "Subscribers have unlimited access to the TFL Bus Operator Incident Reporting API's. Administrator approval is required." -LegalTerms "Transport For London all rights reserved" -ApprovalRequired $ApprovalRequired -State "Published" -SubscriptionRequired $SubscriptionRequired
}
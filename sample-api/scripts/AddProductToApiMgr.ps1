Param(
[string] $apiManagementRg,
[string] $apiManagementName,
[string] $ProductID,
[string] $ProductName,
[string] $ProductDescription,
[string] $LegalTerms
)
$DebugPreference="Continue"

$ApiMgmtContext = New-AzureRmApiManagementContext -ResourceGroupName "$apiManagementRg" -ServiceName "$apiManagementName" 

$product = Get-AzureRmApiManagementProduct -Context $ApiMgmtContext -ProductId $ProductID -ErrorAction SilentlyContinue

if (!$product){
New-AzureRmApiManagementProduct -Context $ApiMgmtContext -ProductId "$ProductID" -Title "$ProductName" -Description $ProductDescription -LegalTerms $LegalTerms -ApprovalRequired $True -State "Published"
}
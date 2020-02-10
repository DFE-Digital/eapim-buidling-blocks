Param(
[string] $apiManagementRg,
[string] $apiManagementName,
[string] $apiName,
[string] $apiId,
[string] $PolicyString
)
$DebugPreference="Continue"

$ApiMgmtContext = New-AzureRmApiManagementContext -ResourceGroupName "$apiManagementRg" -ServiceName "$apiManagementName"

Write-verbose "API Management context initialzied" -verbose

Set-AzureRmApiManagementPolicy -Context $ApiMgmtContext  -ApiId $apiId -PolicyFilePath $PolicyString

Write-verbose "API Management Policy Applied" -verbose

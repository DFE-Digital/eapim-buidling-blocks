Param(
[string] $apiManagementRg,
[string] $apiManagementName,
[string] $apiUrl,
[string] $apiName,
[string] $apiId,
[string] $IRISProductID
)
$DebugPreference="Continue"

$ApiMgmtContext = New-AzureRmApiManagementContext -ResourceGroupName "$apiManagementRg" -ServiceName "$apiManagementName"

$existingApi = Get-AzureRmApiManagementApi -Context $ApiMgmtContext -ApiId $apiId -ErrorAction Continue

if (!$existingApi) {

New-AzureRmApiManagementBackend -Context $ApiMgmtContext -Url $apiUrl -Protocol http -Title $apiName -SkipCertificateChainValidation $true

$api = New-AzureRmApiManagementApi -Context $ApiMgmtContext -Name $apiName -ServiceUrl "$apiUrl" -ApiId $apiId  -Protocols @("http", "https") -Path "$apiName"   

<#ADD API TO PRODUCT#>
Add-AzureRmApiManagementApiToProduct -Context $ApiMgmtContext -ProductId $IRISProductID -ApiId $api.ApiId

}

 
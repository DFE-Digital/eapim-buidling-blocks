Param(
[string] $apiManagementRg,
[string] $apiManagementName,
[string] $apiId,
[string] $swaggerFilePath,
[string] $productID,
[string] $functionAppName,
[string] $functionUrl ,
[string] $functionKey, 
[string] $protocol,
[string] $apiPath = "apis",
)

#Login-AzureRmAccount
#Select-AzureRmSubscription   -Subscription  "C106 - API Management Service - Test"

$DebugPreference="Continue"

if (!(Test-Path $swaggerFilePath)) {
    Write-Output "swagger file does not exist on the location"
  }

$ApiMgmtContext = New-AzureRmApiManagementContext -ResourceGroupName "$apiManagementRg" -ServiceName "$apiManagementName"
Write-verbose "$ApiMgmtContext" -verbose
$DebugPreference="Continue"


$existingApi = Get-AzureRmApiManagementApi -Context $ApiMgmtContext -ApiId $apiId -ErrorAction Continue

if (!$existingApi) {
   $credential = New-AzureRmApiManagementBackendCredential  -Header @{"x-functions-key" = @('$functionKey')}
    New-AzureRmApiManagementBackend -Context $ApiMgmtContext -BackendId $functionAppName -Url $functionUrl -Protocol $protocol  -Credential $credential -Description $functionAppName

}
else
{
   Remove-AzureRmApiManagementApi -Context $ApiMgmtContext -ApiId $apiId -erroraction 'silentlycontinue'
   Remove-AzureRmApiManagementBackend -Context $ApiMgmtContext -BackendId $functionAppName
   $credential = New-AzureRmApiManagementBackendCredential  -Header @{"x-functions-key" = @('$functionKey')}
   New-AzureRmApiManagementBackend  -Context $ApiMgmtContext -BackendId $functionAppName -Url $functionUrl -Protocol $protocol  -Credential $credential -Description $functionAppName

}

Import-AzureRmApiManagementApi -Context $ApiMgmtContext -SpecificationFormat "Swagger" -ApiId $apiId -SpecificationPath $swaggerFilePath -Path $apiPath



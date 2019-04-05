Param(
[string] $apiManagementRg,
[string] $apiManagementName,
[string] $apiId,
[string] $swaggerFilePath,
[string] $productID,
[string] $apiPath,
[string] $functionAppName,
[string] $functionUrl ,
[string] $functionKey, 
[string] $protocol 
)


if (!(Test-Path $swaggerFilePath)) {
    Write-Output "swagger file does not exist on the location"
  }

$ApiMgmtContext = New-AzureRmApiManagementContext -ResourceGroupName "$apiManagementRg" -ServiceName "$apiManagementName"
Write-verbose "$ApiMgmtContext" -verbose
$DebugPreference="Continue"

Write-Output "Context Created"
#$BackEnd = Get-AzureRmApiManagementBackend  -Context $ApiMgmtContext -BackendId $functionAppName
#$cred = $BackEnd.Credentials

# Remove Existing API and Backend Credentials
Remove-AzureRmApiManagementApi -Context $ApiMgmtContext -ApiId $apiId -erroraction 'silentlycontinue'
Remove-AzureRmApiManagementBackend -Context $ApiMgmtContext -BackendId $functionAppName -erroraction 'silentlycontinue'
 
# Create Backend and API
$credential = New-AzureRmApiManagementBackendCredential -AuthorizationHeaderParameter opensesame  -Header @{"x-functions-key" = @($functionKey)}
New-AzureRmApiManagementBackend -Context $ApiMgmtContext -BackendId $functionAppName -Url $functionUrl -Protocol $protocol  -Credential $credential -Description $functionAppName
Write-Output "API BackEnd Created. Going to import API now"

# Import API now
Import-AzureRmApiManagementApi -Context $ApiMgmtContext -SpecificationFormat "Swagger" -ApiId $apiId -SpecificationPath $swaggerFilePath -Path $apiPath

# Add API to product
Add-AzureRmApiManagementApiToProduct -Context $ApiMgmtContext -ProductId $productID -ApiId $apiId 


Write-Output "API Created"


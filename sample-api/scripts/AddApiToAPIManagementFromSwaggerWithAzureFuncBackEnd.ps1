Param(
[string] $apiManagementRg,
[string] $apiManagementName,
[string] $apiId,
[string] $swaggerFilePath,
[string] $productID,
[string] $apiPath = "apis",
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


$BackEnd = Get-AzureRmApiManagementBackend  -Context $ApiMgmtContext -BackendId $functionAppName
$cred = $BackEnd.Credentials

$existingApi = Get-AzureRmApiManagementApi -Context $ApiMgmtContext -ApiId $apiId -ErrorAction Continue

if (!$existingApi) {
   $credential = New-AzureRmApiManagementBackendCredential -AuthorizationHeaderParameter opensesame  -Header @{"x-functions-key" = @('s113d01-rstone-fa-01-key')}
    New-AzureRmApiManagementBackend -Context $ApiMgmtContext -BackendId $functionAppName -Url $functionUrl -Protocol $protocol  -Credential $credential -Description $functionAppName

}
else
{
   Remove-AzureRmApiManagementApi -Context $ApiMgmtContext -ApiId $apiId -erroraction 'silentlycontinue'
   Remove-AzureRmApiManagementBackend -Context $ApiMgmtContext -BackendId $functionAppName
   $credential = New-AzureRmApiManagementBackendCredential -AuthorizationHeaderScheme basic -AuthorizationHeaderParameter opensesame  -Header @{"x-functions-key" = @($functionKey)}
   New-AzureRmApiManagementBackend  -Context $ApiMgmtContext -BackendId $functionAppName -Url $functionUrl -Protocol $protocol  -Credential $credential -Description $functionAppName

}

Import-AzureRmApiManagementApi -Context $ApiMgmtContext -SpecificationFormat "Swagger" -ApiId $apiId -SpecificationPath $swaggerFilePath -Path $apiPath


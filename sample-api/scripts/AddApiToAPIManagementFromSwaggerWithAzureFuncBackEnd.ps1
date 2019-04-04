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


$existingApi = Get-AzureRmApiManagementApi -Context $ApiMgmtContext -ApiId $apiId -ErrorAction Continue

if (!$existingApi) {
   $credential = New-AzureRmApiManagementBackendCredential -AuthorizationHeaderParameter opensesame  -Header @{"x-functions-key" = @($functionKey)}
    New-AzureRmApiManagementBackend -Context $ApiMgmtContext -BackendId $functionAppName -Url $functionUrl -Protocol $protocol  -Credential $credential -Description $functionAppName
    Write-Output "API BackEnd Created"

}
else
{
   Remove-AzureRmApiManagementApi -Context $ApiMgmtContext -ApiId $apiId -erroraction 'silentlycontinue'
   Remove-AzureRmApiManagementBackend -Context $ApiMgmtContext -BackendId $functionAppName
   $credential = New-AzureRmApiManagementBackendCredential -AuthorizationHeaderScheme basic -AuthorizationHeaderParameter opensesame  -Header @{"x-functions-key" = @($functionKey)}
   New-AzureRmApiManagementBackend  -Context $ApiMgmtContext -BackendId $functionAppName -Url $functionUrl -Protocol $protocol  -Credential $credential -Description $functionAppName
    Write-Output "API Existed. Deleted older version.. API BackEnd Created"

}

Import-AzureRmApiManagementApi -Context $ApiMgmtContext -SpecificationFormat "Swagger" -ApiId $apiId -SpecificationPath $swaggerFilePath -Path $apiPath

  Write-Output "API Created"


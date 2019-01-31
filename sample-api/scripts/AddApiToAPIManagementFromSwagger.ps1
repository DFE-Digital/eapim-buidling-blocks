Param(
[string] $apiManagementRg,
[string] $apiManagementName,
[string] $apiId,
[string] $swaggerFilePath,
[string] $productID,
[string] $apiPath = "apis"
)
$DebugPreference="Continue"

$ApiMgmtContext = New-AzureRmApiManagementContext -ResourceGroupName "$apiManagementRg" -ServiceName "$apiManagementName"

Write-verbose "$ApiMgmtContext" -verbose

<#TO FORCE CHANGES TO SWAGGER TO BE PICKED UP NEED TO DELETE FIRST#>
Remove-AzureRmApiManagementApi -Context $ApiMgmtContext -ApiId $apiId -erroraction 'silentlycontinue'

# setting this in base policy through an environment variable rather than in a 'backend'
#New-AzureRmApiManagementBackend -Context $ApiMgmtContext -Url $apiUrl -Protocol http -Title $apiName -SkipCertificateChainValidation $true

Import-AzureRmApiManagementApi -Context $ApiMgmtContext -SpecificationFormat "Swagger" -ApiId $apiId -SpecificationPath $swaggerFilePath -Path $apiPath

<#ADD API TO PRODUCT#>
Add-AzureRmApiManagementApiToProduct -Context $ApiMgmtContext -ProductId $productID -ApiId $apiId 

 
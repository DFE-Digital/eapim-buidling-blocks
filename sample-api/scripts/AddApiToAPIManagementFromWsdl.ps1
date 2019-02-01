Param(
[string] $apiManagementRg,
[string] $apiManagementName,
[string] $apiUrl,
[string] $apiName,
[string] $apiId,
[string] $WsdlFilePath,
[string] $WsdlServiceName,
[string] $WsdlEndpointName,
[string] $ProductID,
[string] $apiPath
)
$DebugPreference="Continue"

$ApiMgmtContext = New-AzureRmApiManagementContext -ResourceGroupName "$apiManagementRg" -ServiceName "$apiManagementName"

Write-verbose "$ApiMgmtContext" -verbose

Write-verbose "$apiUrl" -verbose

<#TO FORCE CHANGES TO WSDL TO BE PICKED UP NEED TO DELETE FIRST#>
Remove-AzureRmApiManagementApi -Context $ApiMgmtContext -ApiId $apiId -erroraction 'silentlycontinue'

#try setting this in base policy through an environment variable rather than in a 'backend'
#New-AzureRmApiManagementBackend -Context $ApiMgmtContext -Url $apiUrl -Protocol http -Title $apiName -SkipCertificateChainValidation $true

Import-AzureRmApiManagementApi -Context $ApiMgmtContext -SpecificationFormat "WSDL" -ApiId $apiId -SpecificationPath "$WsdlFilePath" -ApiType "Soap" -Path "$apiPath" -WsdlServiceName "$WsdlServiceName" -WsdlEndpointName  "$WsdlEndpointName"

<#ADD API TO PRODUCT#>
Add-AzureRmApiManagementApiToProduct -Context $ApiMgmtContext -ProductId $ProductID -ApiId $apiId 




 
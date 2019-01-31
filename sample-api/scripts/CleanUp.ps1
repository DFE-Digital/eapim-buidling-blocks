Param(
[string] $apiManagementRg,
[string] $apiManagementName,
[string] $ProductId,
[string] $ApiId,
[boolean] $DeleteProduct
)
$DebugPreference="Continue"

$ApiMgmtContext = New-AzureRmApiManagementContext -ResourceGroupName "$apiManagementRg" -ServiceName "$apiManagementName"

$global:existingApi = $null
$global:existingBackEnd = $null
$global:existingProp = $null
$global:existingProduct = $null

<# REMOVE API#>
<#############################################################################################>
try {
    $global:existingApi = Get-AzureRmApiManagementApi -Context $ApiMgmtContext -ApiId $apiId -ErrorAction Stop
}
catch {
    Write-Output ("API - "+ $ApiId +" not found.")
}
if ($global:existingApi) {
    Remove-AzureRmApiManagementApi -Context $ApiMgmtContext -ApiId $ApiId
}
<#############################################################################################>


<# REMOVE PRODUCT#>
<#############################################################################################>
try {
    $global:existingProduct = Get-AzureRmApiManagementProduct -Context $ApiMgmtContext -ProductId $ProductId -ErrorAction Stop
}
catch {
    Write-Output ("Product - "+ $ProductId +" not found.")
}
if ($global:existingProduct -and $DeleteProduct) {
    Remove-AzureRmApiManagementProduct -Context $ApiMgmtContext -ProductId $ProductId -DeleteSubscriptions
}
<#############################################################################################>
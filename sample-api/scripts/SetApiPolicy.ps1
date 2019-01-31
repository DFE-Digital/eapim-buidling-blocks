Param(
[string] $apiManagementRg,
[string] $apiManagementName,
[string] $apiName,
[string] $apiId,
[string] $operationId,
[string] $PolicyString
)
$DebugPreference="Continue"

$ApiMgmtContext = New-AzureRmApiManagementContext -ResourceGroupName "$apiManagementRg" -ServiceName "$apiManagementName"

$array = Get-AzureRmApiManagementOperation -Context $ApiMgmtContext -ApiId $apiId 

Write-verbose "checking for operation:" -verbose
Write-verbose "$operationId" -verbose
for ($i=0; $i -lt $array.length; $i++) {
if($array[$i].name -eq "$operationId"){
Write-verbose "Found matching operation for operation:" -verbose
Write-verbose $array[$i]."name" -verbose
Write-verbose $array[$i]."OperationId" -verbose
$operationId = $array[$i]."OperationId"
}
}

Set-AzureRmApiManagementPolicy -Context $ApiMgmtContext -OperationId $operationId -ApiId $apiId -PolicyFilePath $PolicyString

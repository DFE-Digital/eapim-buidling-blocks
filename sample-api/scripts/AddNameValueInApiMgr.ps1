Param(
[string] $apiManagementRg,
[string] $apiManagementName,
[string] $propertyName,
[string] $propertyValue,
[string] $protocol 
)

$ApiMgmtContext = New-AzureRmApiManagementContext -ResourceGroupName "$apiManagementRg" -ServiceName "$apiManagementName"

# Remove existing property ( if it exists)
Remove-AzureRmApiManagementProperty -Context $ApiMgmtContext -PropertyId $propertyName -ErrorAction Continue

# Add property in the APIM
New-AzureRmApiManagementProperty -Context $ApiMgmtContext -Name $propertyName -Value $propertyValue -PropertyId $propertyName

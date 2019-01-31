Param(
[string] $apiManagementRg,
[string] $apiManagementName,
[string] $EnvironmentVariableName,
[string] $EnvironmentVariableValue,
[switch] $Secret,
[string[]] $Tags
)

$ApiMgmtContext = New-AzureRmApiManagementContext -ResourceGroupName "$apiManagementRg" -ServiceName "$apiManagementName"

Remove-AzureRmApiManagementProperty -Context $ApiMgmtContext -PropertyId $EnvironmentVariableName -ErrorAction Continue
New-AzureRmApiManagementProperty -Context $ApiMgmtContext -Name $EnvironmentVariableName -Value $EnvironmentVariableValue -PropertyId $EnvironmentVariableName -Secret:$Secret -Tag $Tags
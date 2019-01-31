Param(
[string] $apiManagementRg,
[string] $apiManagementName,
[string] $EnvironmentPath
)
$DebugPreference="Continue"

$ApiMgmtContext = New-AzureRmApiManagementContext -ResourceGroupName "$apiManagementRg" -ServiceName "$apiManagementName"

Remove-AzureRmApiManagementProperty -Context $ApiMgmtContext -PropertyId "EnvironmentPath" -ErrorAction Continue
New-AzureRmApiManagementProperty -Context $ApiMgmtContext -Name "EnvironmentPath" -Value $EnvironmentPath -PropertyId "EnvironmentPath"

Param(
[string] $apiManagementRg,
[string] $apiManagementName,
[string] $logicAppUrl,
[string] $newTicketBaseUrlPropName ,
[string] $newTicketReWriteUrlPropName, 
[string] $protocol 
)

$LogicAppBaseUrl = $logicAppUrl.Substring(0, $logicAppUrl.IndexOf('/triggers')+9)
$LogicAppRewriteUrl = $logicAppUrl.Substring($logicAppUrl.IndexOf('/triggers')+10, $logicAppUrl.Length-($logicAppUrl.IndexOf('/triggers')+10))
$LogicAppBaseUrl
$LogicAppRewriteUrl

$ApiMgmtContext = New-AzureRmApiManagementContext -ResourceGroupName "$apiManagementRg" -ServiceName "$apiManagementName"

# Remove existing properties
Remove-AzureRmApiManagementProperty -Context $ApiMgmtContext -PropertyId $newTicketBaseUrlPropName -ErrorAction Continue
Remove-AzureRmApiManagementProperty -Context $ApiMgmtContext -PropertyId $newTicketReWriteUrlPropName -ErrorAction Continue

# Add properties
New-AzureRmApiManagementProperty -Context $ApiMgmtContext -Name $newTicketBaseUrlPropName -Value $LogicAppBaseUrl -PropertyId $newTicketBaseUrlPropName
New-AzureRmApiManagementProperty -Context $ApiMgmtContext -Name $newTicketReWriteUrlPropName -Value $LogicAppRewriteUrl -PropertyId $newTicketReWriteUrlPropName
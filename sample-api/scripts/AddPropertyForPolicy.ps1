Param(
[string] $apiManagementRg,
[string] $apiManagementName,
[string] $apiMgmtCallBackURLPropName,
[string] $LogicAppName,
[string[]] $Tags
)
$DebugPreference="Continue"

$ApiMgmtContext = New-AzureRmApiManagementContext -ResourceGroupName "$apiManagementRg" -ServiceName "$apiManagementName"

<#Get the HTTP URL that can be used to invoke the LogicApp to send messages to queue.#>
$CallBackURLObj = Get-AzureRmLogicAppTriggerCallbackUrl -ResourceGroupName $apiManagementRg -Name $LogicAppName -TriggerName "manual"
$CallBackURL = $CallBackURLObj.value
<#Get-AzureRmLogicAppTriggerCallbackUrl -ResourceGroupName $apiManagementRg -Name $LogicAppName -TriggerName "manual" -OutVariable callbackUriInfo
$CallBackURL = [string]"$callbackUriInfo" #>
Write-Verbose $CallBackURL
Write-Output "Success till here"
Write-Output $callbackUriInfo
New-AzureRmApiManagementProperty -Context $ApiMgmtContext -Name $apiMgmtCallBackURLPropName -Value $CallBackURL -PropertyId $apiMgmtCallBackURLPropName -Tags $Tags
Param(
[string] $apiManagementRg,
[string] $apiManagementName,
[string] $ProductID,
[string] $ProductName,
[string] $ProductDescription,
[string] $LegalTerms
)
$DebugPreference="Continue"

$ApiMgmtContext = New-AzureRmApiManagementContext -ResourceGroupName "$apiManagementRg" -ServiceName "$apiManagementName" 

$product = Get-AzureRmApiManagementProduct -Context $ApiMgmtContext -ProductId $ProductID -ErrorAction SilentlyContinue

if (!$product){
    New-AzureRmApiManagementProduct -Context $ApiMgmtContext -ProductId "$ProductID" -Title "$ProductName" -Description $ProductDescription -LegalTerms $LegalTerms -ApprovalRequired $True -State "Published"
    write-host("Added Product into the EAPIM environment.")
    # ADD Product into Developers Group
    $DevGroup = Get-AzureRmApiManagementGroup  -Name "Developers" -Context $ApiMgmtContext
    $APIMProduct = Get-AzureRmApiManagementProduct -Context $ApiMgmtContext -ProductId $ProductID
    Add-AzureRmApiManagementProductToGroup -Context $ApiMgmtContext -GroupId  $DevGroup.GroupId -ProductId $APIMProduct.ProductId
    Write-Output ("API Product - "+ $ProductID +" added into Developers Group.")
}
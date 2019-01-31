Param(
[string] $apiManagementRg,
[string] $apiManagementName,
[string] $apiId,
[string] $operationName,
[string] $operationId,
[string] $methodType,
[string] $urlTemplatePath,
[string] $operationDescription,
[string] $operationRequestRepresentation,
[string] $operationRequestSchema
)
$DebugPreference="Continue"

$ApiMgmtContext = New-AzureRmApiManagementContext -ResourceGroupName "$apiManagementRg" -ServiceName "$apiManagementName"

$Request = New-Object -TypeName Microsoft.Azure.Commands.ApiManagement.ServiceManagement.Models.PsApiManagementRequest
$RequestRepresentation = New-Object -TypeName Microsoft.Azure.Commands.ApiManagement.ServiceManagement.Models.PsApiManagementRepresentation
$RequestRepresentation.ContentType = 'application/json'
$RequestRepresentation.Sample = $operationRequestRepresentation

$Request.Representations = @($requestRepresentation)
Remove-AzureRmApiManagementOperation -Context $ApiMgmtContext -ApiId $apiId -OperationId $operationId -erroraction 'silentlycontinue'
New-AzureRmApiManagementOperation -Context $ApiMgmtContext -ApiId $apiId -OperationId $operationId -Name $operationName -Method $methodType -UrlTemplate $urlTemplatePath -Description $operationDescription -Request $Request 
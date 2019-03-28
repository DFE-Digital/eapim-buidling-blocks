Param(
[string] $EAPIMReaderRoleName,
[string] $EAPIMReaderRoleDefinitionPath
)

# Remove if the role exists. 
Remove-AzureRmRoleDefinition  -Name $EAPIMReaderRoleName -Force

# Create the Role with the updated definition
New-AzureRmRoleDefinition -InputFile $EAPIMReaderRoleDefinitionPath

# Check that the new role has been created
Get-AzureRmRoleDefinition -Name $EAPIMReaderRoleName
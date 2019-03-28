Param(
[string] $EAPIMReaderRoleName,
[string] $EAPIMReaderRoleDefinitionPath
)

Write-Verbose "Creating EAPIM Custom Roles"

Write-Verbose $EAPIMReaderRoleName
Write-Verbose $EAPIMReaderRoleDefinitionPath


# Remove if the role exists. 
Remove-AzureRmRoleDefinition  -Name $EAPIMReaderRoleName -Force

Write-Verbose "Removed existing role"

# Create the Role with the updated definition
New-AzureRmRoleDefinition -InputFile $EAPIMReaderRoleDefinitionPath

Write-Verbose "EAPIM Reader Role Added"

# Check that the new role has been created
Get-AzureRmRoleDefinition -Name $EAPIMReaderRoleName
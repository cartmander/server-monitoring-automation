$jsonPayload = [Console]::In.ReadLine()
$json = ConvertFrom-Json $jsonPayload

$osType = $json.osType
$agent = $json.agent
$scopeType = $json.scopeType
$scope = $json.scope

try 
{
    $filteredVirtualMachines = @{}

    if ($scopeType -eq "ResourceGroup")
    {
        $virtualMachinesByScopeJson = az vm list --resource-group $scope --query "[?contains(storageProfile.osDisk.osType, '$osType') && powerState=='VM running']" -d -o json
    }

    elseif ($scopeType -eq "Tag")
    {
        #$virtualMachinesByScopeJson = az graph query -q "Resources | where type =~ 'Microsoft.Compute/virtualMachines' | where tags['terraform']=='ddd'"
    }
    
    $virtualMachinesByScopeObject =  $virtualMachinesByScopeJson | ConvertFrom-Json

    foreach ($virtualMachine in $virtualMachinesByScopeObject)
    {
        $virtualMachineId = $virtualMachine.id | ConvertTo-Json | % { [System.Text.RegularExpressions.Regex]::Replace($virtualMachine.id, '""', '"') }
        
        foreach ($resource in $virtualMachine.resources)
        {
            if($resource.typePropertiesType -eq $agent)
            {
                az vm extension delete -g $virtualMachine.resourceGroup --vm-name $virtualMachine.name -n $resource.name
            }
        }

        $filteredVirtualMachines += @{$virtualMachineId=$virtualMachineId}
    }

    $virtualMachineList = $filteredVirtualMachines | ConvertTo-Json
    return $virtualMachineList
}

catch
{
    Write-Error $_
    exit 1
}
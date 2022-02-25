$jsonPayload = [Console]::In.ReadLine()
$json = ConvertFrom-Json $jsonPayload

$subscriptionId = $json.subscriptionId
$osType = $json.osType
$agent = $json.agent

try 
{
    $virtualMachinesBySubscriptionJson = az vm list --subscription $subscriptionId --query "[?contains(storageProfile.osDisk.osType, '$osType') && powerState=='VM running']" -d -o json
    $virtualMachinesBySubscriptionObject =  $virtualMachinesBySubscriptionJson | ConvertFrom-Json
    $filteredVirtualMachines = @{}

    foreach ($virtualMachine in $virtualMachinesBySubscriptionObject)
    {
        $virtualMachineId = $virtualMachine.id | ConvertTo-Json | % { [System.Text.RegularExpressions.Regex]::Replace($virtualMachine.id, '""', '"') }
        
        foreach ($resource in $virtualMachine.resources)
        {
            if($resource.typePropertiesType -eq $agent)
            {
                az vm extension delete -g $virtualMachine.resourceGroup --vm-name $virtualMachine.name -n $resource.name
            }
        }

        $filteredVirtualMachines = $filteredVirtualMachines + @{$virtualMachineId=$virtualMachineId}
    }

    $virtualMachineList = $filteredVirtualMachines | ConvertTo-Json
    return $virtualMachineList
}

catch
{
    Write-Error $_
    exit 1
}
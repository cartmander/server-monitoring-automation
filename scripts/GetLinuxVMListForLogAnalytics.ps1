$jsonPayload = [Console]::In.ReadLine()
$json = ConvertFrom-Json $jsonPayload

$subscriptionId = $json.subscriptionId

try 
{
    $virtualMachinesBySubscriptionJson = az vm list --subscription $subscriptionId --query "[?contains(storageProfile.osDisk.osType, 'Linux') && powerState=='VM running']" -d -o json
    $virtualMachinesBySubscriptionObject =  $virtualMachinesBySubscriptionJson | ConvertFrom-Json
    $filteredVirtualMachines = @{}

    foreach ($virtualMachine in $virtualMachinesBySubscriptionObject)
    {
        $virtualMachineId = $virtualMachine.id | ConvertTo-Json | % { [System.Text.RegularExpressions.Regex]::Replace($virtualMachine.id, '""', '"') }
        
        foreach ($resource in $virtualMachine.resources)
        {
            if($resource.id -clike "*OmsAgentForLinux*")
            {
                az vm extension delete -g $virtualMachine.resourceGroup --vm-name $virtualMachine.name -n "OmsAgentForLinux"
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
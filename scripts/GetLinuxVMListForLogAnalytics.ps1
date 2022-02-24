$jsonPayload = [Console]::In.ReadLine()
$json = ConvertFrom-Json $jsonPayload

$subscriptionId = $json.subscriptionId

try 
{
    $virtualMachinesBySubscriptionJson = az vm list --subscription $subscriptionId --query "[? contains(storageProfile.osDisk.osType, 'Linux')]"
    $virtualMachinesBySubscriptionObject =  $virtualMachinesBySubscriptionJson | ConvertFrom-Json
    $filteredVirtualMachines = @{}

    foreach ($virtualMachine in $virtualMachinesBySubscriptionObject)
    {
        $virtualMachineId = $virtualMachine.id | ConvertTo-Json | % { [System.Text.RegularExpressions.Regex]::Replace($virtualMachine.id, '""', '"') }
        
        if($virtualMachine.resources -eq $null)
        {
            $filteredVirtualMachines = $filteredVirtualMachines + @{$virtualMachineId=$virtualMachineId}
        }

        else
        {
            foreach ($resource in $virtualMachine.resources)
            {
                if($resource.id -clike "*OmsAgentForLinux*")
                {
                    az extension remove --name "OmsAgentForLinux"
                    $filteredVirtualMachines = $filteredVirtualMachines + @{$virtualMachineId=$virtualMachineId}
                }
            }
        }
    }

    $virtualMachineList = $filteredVirtualMachines | ConvertTo-Json
    return $virtualMachineList
}

catch
{
    Write-Error $_
    exit 1
}
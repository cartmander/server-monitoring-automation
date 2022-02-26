data "external" "windows_vm_list_by_scope" {
  program = ["Powershell.exe", "Set-ExecutionPolicy Bypass -Scope Process -Force; ./scripts/ListVirtualMachinesByScope.ps1"]
  query = {
    osType = "Windows",
    agent = "MicrosoftMonitoringAgent",
    scopeType = "${var.scope_type}",
    scope = "${var.scope}"
  }
}

data "external" "linux_vm_list_by_scope" {
  program = ["Powershell.exe", "Set-ExecutionPolicy Bypass -Scope Process -Force; ./scripts/ListVirtualMachinesByScope.ps1"]
  query = {
    osType = "Linux",
    agent = "OmsAgentForLinux",
    scopeType = "${var.scope_type}",
    scope = "${var.scope}"
  }
}
data "external" "windows_vms_for_log_analytics_workspace_installation_list" {
  program = ["Powershell.exe", "Set-ExecutionPolicy Bypass -Scope Process -Force; ./scripts/ListVMsForAgentInstallation.ps1"]
  query = {
    osType = "Windows",
    agent = "MicrosoftMonitoringAgent",
    scopeType = "${var.scope_type}",
    scope = "${var.scope}"
  }
}

data "external" "linux_vms_for_log_analytics_workspace_installation_list" {
  program = ["Powershell.exe", "Set-ExecutionPolicy Bypass -Scope Process -Force; ./scripts/ListVMsForAgentInstallation.ps1"]
  query = {
    osType = "Linux",
    agent = "OmsAgentForLinux",
    scopeType = "${var.scope_type}",
    scope = "${var.scope}"
  }
}

data "external" "windows_vms_for_azure_monitor_installation_list" {
  program = ["Powershell.exe", "Set-ExecutionPolicy Bypass -Scope Process -Force; ./scripts/ListVMsForAgentInstallation.ps1"]
  query = {
    osType = "Windows",
    agent = "AzureMonitorWindowsAgent",
    scopeType = "${var.scope_type}",
    scope = "${var.scope}"
  }
}

data "external" "linux_vms_for_azure_monitor_installation_list" {
  program = ["Powershell.exe", "Set-ExecutionPolicy Bypass -Scope Process -Force; ./scripts/ListVMsForAgentInstallation.ps1"]
  query = {
    osType = "Linux",
    agent = "AzureMonitorLinuxAgent",
    scopeType = "${var.scope_type}",
    scope = "${var.scope}"
  }
}
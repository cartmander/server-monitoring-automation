data "external" "windows_vms_for_log_analytics_workspace_installation_list" {
  program = ["Powershell.exe", "Set-ExecutionPolicy Bypass -Scope Process -Force; ./scripts/ListVMsForAgentInstallation.ps1"]
  query = {
    osType = "Windows",
    agent = "MicrosoftMonitoringAgent",
    subscription = "${var.subscription}",
    scopeType = "${var.scope_type}",
    scope = "${var.scope}"
  }
}

data "external" "linux_vms_for_log_analytics_workspace_installation_list" {
  program = ["Powershell.exe", "Set-ExecutionPolicy Bypass -Scope Process -Force; ./scripts/ListVMsForAgentInstallation.ps1"]
  query = {
    osType = "Linux",
    agent = "OmsAgentForLinux",
    subscription = "${var.subscription}",
    scopeType = "${var.scope_type}",
    scope = "${var.scope}"
  }
}

data "external" "windows_vms_for_azure_monitor_installation_list" {
  program = ["Powershell.exe", "Set-ExecutionPolicy Bypass -Scope Process -Force; ./scripts/ListVMsForAgentInstallation.ps1"]
  query = {
    osType = "Windows",
    agent = "AzureMonitorWindowsAgent",
    subscription = "${var.subscription}",
    scopeType = "${var.scope_type}",
    scope = "${var.scope}"
  }
}

data "external" "linux_vms_for_azure_monitor_installation_list" {
  program = ["Powershell.exe", "Set-ExecutionPolicy Bypass -Scope Process -Force; ./scripts/ListVMsForAgentInstallation.ps1"]
  query = {
    osType = "Linux",
    agent = "AzureMonitorLinuxAgent",
    subscription = "${var.subscription}",
    scopeType = "${var.scope_type}",
    scope = "${var.scope}"
  }
}
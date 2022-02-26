data "external" "windows_vms_for_log_analytics_transfer_list" {
  program = ["Powershell.exe", "Set-ExecutionPolicy Bypass -Scope Process -Force; ./scripts/ListVMsForLogAnalyticsTransfer.ps1"]
  query = {
    osType = "Windows",
    agent = "MicrosoftMonitoringAgent",
    scopeType = "${var.scope_type}",
    scope = "${var.scope}"
  }
}

data "external" "linux_vms_for_log_analytics_transfer_list" {
  program = ["Powershell.exe", "Set-ExecutionPolicy Bypass -Scope Process -Force; ./scripts/ListVMsForLogAnalyticsTransfer.ps1"]
  query = {
    osType = "Linux",
    agent = "OmsAgentForLinux",
    scopeType = "${var.scope_type}",
    scope = "${var.scope}"
  }
}
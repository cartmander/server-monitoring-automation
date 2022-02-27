resource "azurerm_virtual_machine_extension" "microsoft_monitoring_agent" {
  for_each                   = var.has_log_analytics_workspace ? data.external.windows_vms_for_log_analytics_workspace_installation_list.result : {}
  name                       = "MicrosoftMonitoringAgent"
  virtual_machine_id         = each.value
  publisher                  = "Microsoft.EnterpriseCloud.Monitoring"
  type                       = "MicrosoftMonitoringAgent"
  type_handler_version       = "1.0"
  auto_upgrade_minor_version = "true"
  settings = <<SETTINGS
    {
      "workspaceId": "${var.log_analytics_workspace_key}"
    }
SETTINGS
   protected_settings = <<PROTECTED_SETTINGS
    {
      "workspaceKey": "${var.log_analytics_workspace_key}"
    }
PROTECTED_SETTINGS
}

resource "azurerm_virtual_machine_extension" "oms_agent_for_linux" {
  for_each                   = var.has_log_analytics_workspace ? data.external.linux_vms_for_log_analytics_workspace_installation_list.result : {}
  name                       = "OmsAgentForLinux"
  virtual_machine_id         = each.value
  publisher                  = "Microsoft.EnterpriseCloud.Monitoring"
  type                       = "OmsAgentForLinux"
  type_handler_version       = "1.13"
  auto_upgrade_minor_version = "true"
  settings = <<SETTINGS
    {
      "workspaceId": "${var.log_analytics_workspace_id}"
    }
SETTINGS
   protected_settings = <<PROTECTED_SETTINGS
    {
      "workspaceKey": "${var.log_analytics_workspace_key}"
    }
PROTECTED_SETTINGS
}

resource "azurerm_virtual_machine_extension" "azure_monitor_windows_agent" {
  for_each                   = var.has_azure_monitor ? data.external.windows_vms_for_azure_monitor_installation_list.result : {}
  name                       = "AzureMonitorWindowsAgent"
  virtual_machine_id         = each.value
  publisher                  = "Microsoft.Azure.Monitor"
  type                       = "AzureMonitorWindowsAgent"
  type_handler_version       = "1.0"
  auto_upgrade_minor_version = "true"
}

resource "azurerm_virtual_machine_extension" "azure_monitor_linux_agent" {
  for_each                   = var.has_azure_monitor ? data.external.linux_vms_for_azure_monitor_installation_list.result : {}
  name                       = "AzureMonitorLinuxAgent"
  virtual_machine_id         = each.value
  publisher                  = "Microsoft.Azure.Monitor"
  type                       = "AzureMonitorLinuxAgent"
  type_handler_version       = "1.5"
  auto_upgrade_minor_version = "true"
}
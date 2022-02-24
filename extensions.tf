resource "azurerm_virtual_machine_extension" "microsoft_monitoring_agent" {
  for_each                   = data.external.get_windows_vm_list_for_log_analytics.result
  name                       = "MicrosoftMonitoringAgent"
  virtual_machine_id         = each.value
  publisher                  = "Microsoft.EnterpriseCloud.Monitoring"
  type                       = "MicrosoftMonitoringAgent"
  type_handler_version       = "1.0"
  auto_upgrade_minor_version = "true"
  settings = <<SETTINGS
    {
      "workspaceId": "${var.workspace_id}"
    }
SETTINGS
   protected_settings = <<PROTECTED_SETTINGS
   {
      "workspaceKey": "${var.workspace_key}"
   }
PROTECTED_SETTINGS
}

resource "azurerm_virtual_machine_extension" "oms_agent_for_linux" {
  for_each                   = data.external.get_linux_vm_list_for_log_analytics.result
  name                       = "OmsAgentForLinux"
  virtual_machine_id         = each.value
  publisher                  = "Microsoft.EnterpriseCloud.Monitoring"
  type                       = "OmsAgentForLinux"
  type_handler_version       = "1.13"
  auto_upgrade_minor_version = "true"
  settings = <<SETTINGS
    {
      "workspaceId": "${var.workspace_id}"
    }
SETTINGS
   protected_settings = <<PROTECTED_SETTINGS
   {
      "workspaceKey": "${var.workspace_key}"
   }
PROTECTED_SETTINGS
}
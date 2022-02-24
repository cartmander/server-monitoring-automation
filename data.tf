data "azurerm_client_config" "current_session" {

}

data "external" "get_windows_vm_list_for_log_analytics" {
  program = ["Powershell.exe", "Set-ExecutionPolicy Bypass -Scope Process -Force; ./scripts/GetWindowsVMListForLogAnalytics.ps1"]
  query = {
    subscriptionId = data.azurerm_client_config.current_session.subscription_id
  }
}

data "external" "get_linux_vm_list_for_log_analytics" {
  program = ["Powershell.exe", "Set-ExecutionPolicy Bypass -Scope Process -Force; ./scripts/GetLinuxVMListForLogAnalytics.ps1"]
  query = {
    subscriptionId = data.azurerm_client_config.current_session.subscription_id
  }
}
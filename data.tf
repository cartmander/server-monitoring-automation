data "azurerm_client_config" "current_session" {

}

data "external" "get_windows_vm_list_for_log_analytics" {
  program = ["Powershell.exe", "Set-ExecutionPolicy Bypass -Scope Process -Force; ./scripts/ListVMBySubscription.ps1"]
  query = {
    subscriptionId = data.azurerm_client_config.current_session.subscription_id,
    osType = "Windows",
    agent = "MicrosoftMonitoringAgent"
  }
}

data "external" "get_linux_vm_list_for_log_analytics" {
  program = ["Powershell.exe", "Set-ExecutionPolicy Bypass -Scope Process -Force; ./scripts/ListVMBySubscription.ps1"]
  query = {
    subscriptionId = data.azurerm_client_config.current_session.subscription_id,
    osType = "Linux",
    agent = "OmsAgentForLinux"
  }
}
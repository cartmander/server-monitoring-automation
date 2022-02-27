locals {
  has_valid_log_analytics_workspace_values = var.has_log_analytics_workspace && var.log_analytics_workspace_id != "" && var.log_analytics_workspace_key != ""
  has_valid_azure_monitor_values = var.has_azure_monitor && var.has_azure_monitor
}
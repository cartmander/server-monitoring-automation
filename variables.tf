variable "scope_type" {
  description = "The scope type of the VMs that will be modified"
  type = string
}

variable "scope" {
  description = "The scope of the VMs that will be modified"
  type = string
}

variable "has_log_analytics_workspace" {
  description = "If Log Analytics Workspace should be installed for both Windows and Linux VMs"
  type = bool
}

variable "log_analytics_workspace_id" {
  description = "The log analytics workspace ID that the VMs will use"
  type = string
}

variable "log_analytics_workspace_key" {
  description = "The log analytics workspace key that the VMs will use"
  type = string
}

variable "has_azure_monitor" {
  description = "If Azure Monitor should be installed for both Windows and Linux VMs"
  type = bool
}
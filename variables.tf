variable "workspace_id" {
  description = "The log analytics workspace ID that the VMs will use"
  type = string
}

variable "workspace_key" {
  description = "The log analytics workspace key that the VMs will use"
  type = string
}

variable "scope_type" {
  description = "The scope type of the VMs that will be modified"
  type = string
}

variable "scope" {
  description = "The scope of the VMs that will be modified"
  type = string
}
# Azure Agent Installation Automation

Running this Terraform automation will allow you to transfer your specified Agent extensions to a certain scope of Virtual Machines under a current subscription in Azure.
## Terraform tfvars  variables

Provide the following values in .tfvars:

- Scope Type - (string) ResourceGroup or Tag
- Scope - (string) Resource Group Name / Value for a "Terraform" Key (Example in Azure: Terraform: {value of your choice})
- Log Analytics Workspace ID - (string) ID of the new Log Analytics Workspace
- Log Analytics Workspace Key - (string) Key of the new Log Analytics Workspace
- Has Log Analytics Workspace - (bool) If Log Analytics Workspace should be installed for both Windows and Linux VMs
- Has Azure Monitor - (bool) If Azure Monitor should be installed for both Windows and Linux VMs
## Expected Output

Whatever Agent extensions you are allowing to be installed using this automation, the old Agent extensions of the VMs of a specified scope should now be replaced by the ones you provided in .tfvars. If there are no existing Agent extensions for certain VMs, they still should have the new Agent extensions.
# Azure Agent Extension Transfer Automation

Running this Terraform automation will allow you to replace existing Log Analytics Workspace extensions for a certain scope of virtual machines and connect them to your newly specified Log Analytics Worksplace.
## Terraform tfvars  variables

Provide the following values in .tfvars:

- Workspace ID - ID of the new Log Analytics Workspace
- Workspace Key - Key of the new Log Analytics Workspace
- Scope Type - accepted values are either "ResourceGroup" or "Tag"
- Scope - IF: ResourceGroup - name of resource group | IF: Tag - value for the "Terraform" Key
## Output

The old Log Analytics extensions of the VMs of a specified scope should now be replaced by the one you provided in .tfvars. If there is no existing Log Analytics extension for certain VMs, it should still have the new Log Analytics extension.
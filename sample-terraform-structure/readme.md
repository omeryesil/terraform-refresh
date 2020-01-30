# Terraform VCS Structure Template 

This is a personal repo to define folder structure template for Terraform 

**References**
- Repository Structure : <https://www.terraform.io/docs/cloud/workspaces/repo-structure.html>
- Design Your Organization’s Workspace Structure : https://www.terraform.io/docs/cloud/guides/recommended-practices/part3.3.html#3-design-your-organization-s-workspace-structure
- Terraform Recommended Practices : https://www.terraform.io/docs/cloud/guides/recommended-practices/index.html

## Principles / Guidelines

1. Each repository containing Terraform code should be a manageable chunk of infrastructure, such as an application, service, or specific type of infrastructure (like common networking infrastructure).

2. When repositories are interrelated, we recommend using remote state to transfer information between workspaces

3. Small configurations connected by  <a href="https://www.terraform.io/docs/providers/terraform/d/remote_state.html" target="_blank">remote state</a> are more efficient for collaboration than monolithic repos, because they let you update infrastructure without running unnecessary plans in unrelated workspaces

4. Each environment should have its own workspace (dev, test, uat, prod..)

5. Use the same repository and branch for every environment of a given app or service — write your Terraform code such that you can differentiate the environments via variables, and set those variables appropriately per workspace





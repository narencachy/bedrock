variable "resource_group_name" {
  type = "string"
}

variable "resource_group_location" {
  type = "string"
}

variable "cluster_name" {
  type = "string"
}

variable "cluster_location" {
  type = "string"
}

variable "dns_prefix" {
  type = "string"
}

variable "virtual_node_subnet_cidr" {
  type = "string"
}

variable "cluster_subnet_cidr" {
  type = "string"
}

variable "vnet_cidr" {
  type = "string"
}

variable "agent_vm_count" {
  type    = "string"
  default = "3"
}

variable "agent_vm_size" {
  type    = "string"
  default = "Standard_DS3_v2"
}

variable "admin_user" {
  type    = "string"
  default = "azureuser"
}

variable "ssh_public_key" {
  type = "string"
}

variable "service_principal_id" {
  type = "string"
}

variable "service_principal_secret" {
  type = "string"
}

variable "flux_repo_url" {
  type    = "string"
  default = "https://github.com/weaveworks/flux.git"
}

variable "kubernetes_version" {
  type = "string"
}

variable "gitops_url" {
  type = "string"
}

variable "gitops_ssh_key" {
  type = "string"
}

variable "output_directory" {
  type    = "string"
  default = "./output"
}

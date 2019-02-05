variable "resource_group_name" {
  type = "string"
}

variable "resource_group_location" {
  type = "string"
}

variable "cluster_subnet_id" {
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

variable "client_id" {
  type = "string"
}

variable "client_secret" {
  type = "string"
}

variable "agent_vm_count" {
  type = "string"
}

variable "agent_vm_size" {
  type = "string"
}

variable "kubernetes_version" {
  type    = "string"
  default = "1.11.6"
}

variable "admin_user" {
  type = "string"
}

variable "ssh_public_key" {
  type = "string"
}

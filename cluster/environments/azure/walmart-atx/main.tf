module "provider" {
  source = "../../../templates/providers/azure/default"
}

module "vnet" {
  source              = "Azure/vnet/azurerm"
  resource_group_name = "${var.resource_group_name}"
  location            = "${var.resource_group_location}"
  address_space       = "${var.vnet_cidr}"
  subnet_prefixes     = ["${var.cluster_subnet_cidr}", "${var.virtual_node_subnet_cidr}"]
  subnet_names        = ["${var.cluster_name}-cluster-subnet", "${var.cluster_name}-virtual-node-subnet"]

  tags = {
    environment = "prod"
  }
}

module "aks_flux" "cluster" {
  source = "../../../templates/azure/aks-flux"

  resource_group_name     = "${var.resource_group_name}"
  resource_group_location = "${var.resource_group_location}"
  cluster_name            = "${var.cluster_name}"
  cluster_location        = "${var.cluster_location}"
  kubernetes_version      = "${var.kubernetes_version}"
  dns_prefix              = "${var.dns_prefix}"
  cluster_subnet_id       = "${module.vnet.vnet_subnets[0]}"
  agent_vm_count          = "${var.agent_vm_count}"
  agent_vm_size           = "${var.agent_vm_size}"
  admin_user              = "${var.admin_user}"
  ssh_public_key          = "${var.ssh_public_key}"
  client_id               = "${var.service_principal_id}"
  client_secret           = "${var.service_principal_secret}"
  output_directory        = "${var.output_directory}"
  flux_repo_url           = "${var.flux_repo_url}"
  gitops_url              = "${var.gitops_url}"
  gitops_ssh_key          = "${var.gitops_ssh_key}"
}

resource "null_resource" "cluster_creation_barrier" {
  provisioner "local-exec" {
    command = "echo ${module.aks_flux.kube_config} > /dev/null"
  }
}

/*
resource "null_resource" "install_virtual_node_extension" {
  provisioner "local-exec" {
    command = "az extension add --source https://aksvnodeextension.blob.core.windows.net/aks-virtual-node/aks_virtual_node-0.2.0-py2.py3-none-any.whl --yes"
  }
}
*/
resource "null_resource" "enable_virtual_node_addon" {
  provisioner "local-exec" {
    command = "az aks enable-addons --resource-group ${var.resource_group_name} --name ${var.cluster_name} --addons virtual-node --subnet-name ${var.cluster_name}-virtual-node-subnet"
  }

  depends_on = ["null_resource.cluster_creation_barrier"]
}

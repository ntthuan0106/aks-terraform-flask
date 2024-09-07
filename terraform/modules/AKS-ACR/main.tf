resource "azurerm_resource_group" "aks_rg" {
  name     = var.rg_name
  location = var.aks_location
}

resource "azurerm_kubernetes_cluster" "aks-cluster" {
  name                = var.k8s_cluster_name
  location            = azurerm_resource_group.aks_rg.location
  resource_group_name = azurerm_resource_group.aks_rg.name
  dns_prefix          = "Thuan20521995"

  sku_tier = "Free"
  
  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_B2s"
    os_sku = "Ubuntu"
  }

  identity {
    type = "SystemAssigned"
  }

  kubernetes_version = "1.28.9"

  tags = {
    Environment = "Test"
  }
}
resource "azurerm_container_registry" "acr" {
  resource_group_name = azurerm_resource_group.aks_rg.name
  location = azurerm_resource_group.aks_rg.location
  name = var.acr_name
  sku = "Basic"
}
resource "azurerm_role_assignment" "example" {
  principal_id                     = azurerm_kubernetes_cluster.aks-cluster.kubelet_identity[0].object_id
  role_definition_name             = "AcrPull"
  scope                            = azurerm_container_registry.acr.id
  skip_service_principal_aad_check = true
}
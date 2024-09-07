module "sql_db" {
  source = "./modules/MsSQL"
  rg_name = "db_test"
  admin_username = var.admin_username
  admin_password = var.admin_password
}

module "acr_attach_aks" {
  source = "./modules/AKS-ACR"
  rg_name = "Cluster"
  acr_name = "ACRthuantest"
  k8s_cluster_name = "cluster"
}

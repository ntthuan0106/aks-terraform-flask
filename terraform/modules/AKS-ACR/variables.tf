variable "rg_name" {
  type = string
}
variable "aks_location" {
  type = string
  default = "Southeast Asia"
}
variable "k8s_cluster_name" {
  type = string
}
variable "acr_name" {
  type = string
}
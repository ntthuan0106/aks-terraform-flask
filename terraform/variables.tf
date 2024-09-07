variable "subscription_id" {
  description = "Azure Subscription ID"
  type        = string
}
variable "client_id" {
  description = "Azure Client ID"
  type        = string
}
variable "client_secret" {
  description = "Azure Client Secret"
  type        = string
  sensitive   = true
}
variable "tenant_id" {
  description = "Azure Tenant ID"
  type        = string
}
variable "admin_username" {
  description = "SQL admin username"
}
variable "admin_password" {
  description = "SQL admin password"
  type = string
}

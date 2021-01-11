variable "project" {
  type        = string
  description = "Application Name"
}

variable "project_id" {
  type        = string
  description = "GCP Project ID"
}

# define GCP zone
variable "gcp_zone" {
  type        = string
  description = "GCP Zone"
}
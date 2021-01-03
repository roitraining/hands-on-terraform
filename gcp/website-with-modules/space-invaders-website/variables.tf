variable "project" {
  type    = string
  default = "my-project"
}

variable "project_id" {
  description = "The GCP Project ID."
  type        = string
}

variable "regions" {
  type    = set(string)
}
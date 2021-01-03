variable "project" {
  type    = string
}

variable "regions" {
  type    = set(string)
}

variable "instance_group" {
  type = any
}
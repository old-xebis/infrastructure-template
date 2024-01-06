variable "number" {
  description = "Number of instances to create."
  type = number
  default = 0
}

variable "name" {
  description = "Name of the server to create."
  type = string
  nullable = false
}

variable "server_type" {
  description = "Name of the server type this server should be created with."
  type = string
  default = "cx11"
}

variable "image" {
  description = "Name or ID of the image the server is created from."
  type = string
  default = "ubuntu-22.04"
}

variable "location" {
  description = "The location name to create the server in."
  type = string
  nullable = false
}

variable "user_data" {
  description = "Cloud-Init user data to use during server creation."
  type = string
}

variable "labels" {
  description = "User-defined labels (key-value pairs)."
  type = map(string)
  default = {}
}

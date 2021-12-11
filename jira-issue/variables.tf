variable "url" {
  type        = string
}

variable "user" {
  type        = string
}

variable "password" {
  type        = string
  sensitive   = true
}

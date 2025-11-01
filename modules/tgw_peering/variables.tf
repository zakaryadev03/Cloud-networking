variable "tgw_id" {
  description = "The ID of the transit gateway."
  type        = string
}

variable "peer_tgw_id" {
  description = "The ID of the peer transit gateway."
  type        = string
}

variable "peer_region" {
  description = "The region of the peer transit gateway."
  type        = string
}

variable "project_name" {
  description = "The name of the project for tagging purposes."
  type        = string
}
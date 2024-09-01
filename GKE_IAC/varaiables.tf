# variables.tf
variable "project_id" {
  type        = string
  description = "Shortlet app"
  default = "moonlit-state-434311-c8"
}

variable "gke_name" {
  type        = string
  description = "GKE name"
  default = "alpha-gke"
}

variable "region" {
  type        = string
  description = "The GCP region"
  default     = "us-central1"
}

variable "zone" {
  type        = string
  description = "The GCP region"
  default     = "us-central1-a"
}

variable "network_name" {
  type        = string
  description = "The name of the VPC network"
  default     = "alpha-vpc"
}

variable "subnetwork_name" {
  type        = string
  description = "The name of the subnetwork"
  default     = "alpha-subnet1"
}

variable "positive" {
  type        = bool
  description = "True"
  default     = true
}

variable "negative" {
  type        = bool
  description = "False"
  default     = false
}

variable "master_ipv4_cidr_block" {
  type        = string
  description = "Cidr "
  default     = "172.16.0.0/28"
}

variable "nodepool_name" {
  type        = string
  description = "nodepool name "
  default     = "default-node-pool"
}

variable "machine_type" {
  type        = string
  description = "machine type  "
  default     = "e2-medium"
}

variable "disk_type" {
  type        = string
  description = "disk typ "
  default     = "pd-standard"
}

variable "image_type" {
  type        = string
  description = "image type "
  default     = "ubuntu_containerd"
}

variable "min_count" {
  type        = number
  description = "min_count "
  default     = 1
}
variable "max_count" {
  type        = number
  description = "max_count "
  default     = 2
}
variable "local_ssd_count" {
  type        = number
  description = "local_ssd_count "
  default     = 0
}
variable "disk_size_gb" {
  type        = number
  description = "disk_size_gb"
  default     = 20
}





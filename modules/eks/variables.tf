variable "cluster_name" {
  type        = string
  description = "Name of the EKS cluster"
}

variable "cluster_version" {
  type        = string
  description = "Kubernetes version"
  default     = "1.33"
}

variable "subnet_ids" {
  type        = list(string)
  description = "Subnets to use for EKS"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID for the cluster"
}

variable "desired_size" {
  type        = number
  default     = 2
}

variable "max_size" {
  type        = number
  default     = 3
}

variable "min_size" {
  type        = number
  default     = 1
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags to apply to resources"
}

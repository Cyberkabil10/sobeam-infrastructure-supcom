variable "repo_name" {
  type        = string
  description = "Name of the ECR repository"
  default = "sobeam"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply"
  default     = {}
}

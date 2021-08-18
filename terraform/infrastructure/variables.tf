variable "task_id" {
    type = string
}

variable "default_tags" {
    type = map
    default = {
        owner = "sergey.goncharov"
    }
}

variable "vpc_cidr" {
    type = string
}

variable "availability_zones" {
    type = list
}

variable "subnet_index" {
    type = list
    default = ["a", "b"]
}

variable "private_subnet_cidrs" {
    type = list
}

variable "public_subnet_cidrs" {
    type = list
}

variable "kubernetes_service_account_namespace" {
  type = string
  default = "kube-system"
}

variable "kubernetes_service_account_name" {
  type = string
  default = "eks"
}

variable "database_endpoint" {
  type = string
}

variable "database_username" {
  type = string
}

variable "database_password" {
  type = string
}
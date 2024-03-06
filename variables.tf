variable "env" {
  default     = "dev"
  description = "Name of the environment"
}

variable "application" {
  default = "mlflow-terraform"
}

variable "region" {
  default = "us-east-1"
}

variable "ami" {
  type    = string
  default = "ami-07d9b9ddc6cd8dd30"
}

variable "instance_type" {
  type    = string
  default = "t2.small"
}

variable "mlflow_port" {
  default = 8080
  description = "UI port for accessing mlflow results"
}

variable "internet_cidr" {
  default     = "0.0.0.0/0"
  description = "Cidr block for the internet"
}
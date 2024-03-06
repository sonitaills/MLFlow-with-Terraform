output "mlflow_URL" {
  value = "http://${aws_instance.mlflow_instance.public_ip}:${var.mlflow_port}"
}

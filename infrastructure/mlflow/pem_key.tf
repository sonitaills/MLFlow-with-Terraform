resource "aws_key_pair" "mlflow_key" {
  key_name   = "mlflow_key"
  public_key = file("../pem/mlflow.pem.pub")
}
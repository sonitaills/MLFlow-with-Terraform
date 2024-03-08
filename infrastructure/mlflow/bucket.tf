resource "aws_s3_bucket" "mlflow-bucket" {
  bucket = "${var.application}-${var.env}"

}

resource "aws_ssm_parameter" "mlflow-bucket_url" {
  name  = "/${var.application}/${var.env}/ARTIFACT_URL"
  type  = "SecureString"
  value = "s3://${aws_s3_bucket.mlflow-bucket.bucket}"

  tags = local.tags
}
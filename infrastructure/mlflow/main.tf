terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.4.0"
    }
  }
  backend "s3" {
    bucket = "moray-terraform-state"
    key    = "test/terraform.tfstate"
    region = "us-east-1"
  }
required_version = ">= 1.5"
}

provider "aws" {
  region = var.region

  default_tags {
    tags = local.tags
  }
}

# Launch master node
resource "aws_instance" "mlflow_instance" {
  ami           = var.ami
  instance_type = var.instance_type
  tags = local.tags
  key_name        = aws_key_pair.mlflow_key.key_name
  security_groups = ["mlflow_sg"]

  user_data =<<EOF
#!/bin/bash
sudo apt update
sudo apt install -y pip
sudo apt install -y python3-venv

pip install awscli==1.32.54
pip install mlflow==2.11.0

echo 'mlflow server -h 0.0.0.0 -p ${var.mlflow_port} --default-artifact-root ${aws_s3_bucket.mlflow-bucket.bucket}' > /home/ubuntu/mlflow_crontab.sh
chmod +x /home/ubuntu/mlflow_crontab.sh
echo "Starting mlflow"
bash /home/ubuntu/mlflow_crontab.sh
EOF

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("../pem/mlflow.pem")
    host        = self.public_ip
  }

}
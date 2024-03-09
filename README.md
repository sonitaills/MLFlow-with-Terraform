The goal of this repository is to provide a MLflow server running on the cloud for team colaboration

### Environment setup
Clone this repository and from the CLI run:
```
bash setup.sh
```
This will install the necessary packages for running terraform and set MLflow tracking.
After that, insert your AWS credentials through CLI by typing `aws configure`. If you do not have any credential set, please follow the instructions on [this link](https://docs.aws.amazon.com/kms/latest/developerguide/create-keys.html).

### PEM key generation
We will need to generate a PEM key to access the remote instance that will be created and set a crontab configuration. From CLI:
```
ssh-keygen -t rsa -b 4096 -C "mlflow.pem" -f ./infrastructure/pem/mlflow.pem
```
Make sure that you are on the root of the repository.

### Bucket for storing terraform state
Since this might be an application that will be managed by different people, the terraform state was placed in an S3 bucket. Create a bucket and adjust the 
corresponding bucket name for trackin in the file `main.tf` -> `backend` -> `bucket`

### Creating infrasctrucure
Go to `./infrastucture/mlflow` folder and type `terraform init`. After that, type `terraform plan` and make sure the all 5 resources will be correctly created.
- aws_instance
- aws_key_pair
- aws_s3_bucket
- aws_security_group
- aws_ssm_parameter
If everything looks good type `terraform apply` and follow the instructions.

### Accessing the instance for setting up reboot options (optional)
Once the istance is created you van access it and change the crontab to make MLflow service restart everytime the machine is rebooted. To do so, first log into the machine with:
```
ssh -i ./pem/mlflow.pem ubuntu@<your-machine-public-ipv4-address>
```
You can find your Public-IPv4-address through the AWS console, go to instances and click on your `instance id`.
Keep in mind that the path to the pem key will have to be adjusted depending on which folder you are running this command. Finally, in the remote machine type:
```
sudo echo "@reboot /bin/bash /home/ubuntu/mlflow_crontab.sh"
```

### Tracking experiments
To start tracking experiments, first find the MLfow Public IPv4 DNS. Then, in the machine where the experiments will be ran:
```
export MLFLOW_TRACKING_URI=http://<your-machine-public-ipv4-dns>:port
```
And you are all set! You can access the MLflow UI from `<your-machine-public-ipv4-dns>:port` (code defaults to 8080)

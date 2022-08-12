# tech_assignment documentation
follow README.md

## Installation steps

1. Setup AWS profile with the name `terraform-assignment` under `"~/.aws/credentials"`, i am assuming you have all the required permission to create and setup IAM role, policy, lambda function, dynamo_db, SNS.

2. Extract the tech_assignment.zip file containing the code.
    unzip -q tech_assignment.zip -d <path/to/extract>

3. Change the dir to `path/to/extract`  

4. Create a zip file for the updated code using below command for lambda-function 
    `zip ${PWD}/terraform/lambda_code.zip ReceivePrometheusSNSNotifications.py`

5. Now move to terraform folder
    `cd ${PWD}/terraform`

6. Setup the infra for this assignment on AWS using below command:
    `terraform init`
    `terraform apply`

7. There are all to-geather 12 resources which needs to be created.

8. After terraform apply is successfull, you can test by publishing the alert content in `LambdaTestInput.txt` from `test-cluster-PrometheusAlerts` SNS topic.

9. Verify the data getting inserted in dynamo DB `EKS_cluster_monitoring` table.

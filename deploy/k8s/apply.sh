aws rds --region ap-northeast-1 describe-db-instances --query "DBInstances[*].Endpoint.Address" --output text > tmpfile
export RDS_ENDPOINT=$(cat tmpfile)
rm tmpfile

envsubst '$$RDS_ENDPOINT' < ./config/rails_config.yaml > ./config/rails_config_converted.yaml
envsubst '$$AWS_ACCOUNT_ID $$AWS_REGION $$AWS_ECR_REPOSITORY $$BACKEND_IMAGE_NAME $$BACKEND_IMAGE_VERSION' < ./settings/set_db_job.yaml >  ./settings/set_db_job_converted.yaml
envsubst '$$AWS_ACCOUNT_ID $$AWS_REGION $$AWS_ECR_REPOSITORY $$FRONTEND_IMAGE_NAME $$FRONTEND_IMAGE_VERSION $$BACKEND_IMAGE_NAME $$BACKEND_IMAGE_VERSION' < ./deployment.yaml >  ./deployment_converted.yaml

aws eks update-kubeconfig --name weatherreport-prod-cluster

kubectl apply -f ./config/rails_config_converted.yaml
kubectl apply -f ./config/vue_config.yaml

kubectl apply -f ./settings/set_db_job_converted.yaml

kubectl apply -f ./deployment_converted.yaml

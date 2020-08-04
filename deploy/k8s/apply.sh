aws rds --region ap-northeast-1 describe-db-instances --query "DBInstances[*].Endpoint.Address" --output text > tmpfile
export RDS_ENDPOINT=$(cat tmpfile)
rm tmpfile

aws iam list-roles --region ap-northeast-1 --query "Roles[?RoleName == 'route53-externaldns-controller'].[Arn]" --output text > tmpfile
export ROUTE53_EXDNS_CONTROLLER_ARN=$(cat tmpfile)
rm tmpfile

envsubst '$$RDS_ENDPOINT' < ./config/rails_config.yaml > ./config/rails_config_converted.yaml
envsubst '$$AWS_ACCOUNT_ID $$AWS_REGION $$AWS_ECR_REPOSITORY $$BACKEND_IMAGE_NAME $$BACKEND_IMAGE_VERSION' < ./settings/set_db_job.yaml >  ./settings/set_db_job_converted.yaml
envsubst '$$AWS_ACCOUNT_ID $$AWS_REGION $$AWS_ECR_REPOSITORY $$FRONTEND_IMAGE_NAME $$FRONTEND_IMAGE_VERSION $$BACKEND_IMAGE_NAME $$BACKEND_IMAGE_VERSION' < ./deployment.yaml >  ./deployment_converted.yaml
envsubst '$$ROUTE53_EXDNS_CONTROLLER_ARN' < ./external-dns-manifest.yaml > ./external-dns-manifest_converted.yaml

aws eks --region ap-northeast-1 update-kubeconfig --name weatherreport-prod-cluster

kubectl apply -f ./config/rails_config_converted.yaml
kubectl apply -f ./config/vue_config.yaml

kubectl apply -f ./settings/set_db_job_converted.yaml

kubectl apply -f ./deployment_converted.yaml

kubectl apply -f ./external-dns-manifest_converted.yaml

envsubst '$$RDS_ENDPOINT' < ./k8s/config/rails_config.yaml > ./k8s/config/rails_config_converted.yaml
envsubst '$$AWS_ACCOUNT_ID $$AWS_DEFAULT_REGION $$AWS_ECR_REPOSITORY_NAME $$BACKEND_IMAGE_NAME $$BACKEND_IMAGE_VERSION' < ./k8s/settings/set_db_job.yaml >  ./k8s/settings/set_db_job_converted.yaml
envsubst '$$AWS_ACCOUNT_ID $$AWS_DEFAULT_REGION $$AWS_ECR_REPOSITORY_NAME $$FRONTEND_IMAGE_NAME $$FRONTEND_IMAGE_VERSION $$BACKEND_IMAGE_NAME $$BACKEND_IMAGE_VERSION' < ./k8s/deployment.yaml >  ./k8s/deployment_converted.yaml

aws eks update-kubeconfig --name weatherreport-prod-cluster

kubectl apply -f ./k8s/config/rails_config_converted.yaml
kubectl apply -f ./k8s/config/vue_config.yaml

kubectl apply -f ./k8s/settings/set_db_job_converted.yaml

kubectl apply -f ./k8s/deployment_converted.yaml

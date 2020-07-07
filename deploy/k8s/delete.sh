aws eks update-kubeconfig --name weatherreport-prod-cluster

kubectl delete -f ./k8s/deployment.yaml

kubectl delete -f ./k8s/settings/set_db_job.yaml

kubectl delete -f ./k8s/config/vue_config.yaml
kubectl delete -f ./k8s/config/rails_config.yaml

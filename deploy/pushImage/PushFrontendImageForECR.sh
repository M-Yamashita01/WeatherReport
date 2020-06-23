aws ecr get-login-password --profile my-profile-name | \
docker login --username AWS --password-stdin $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com

docker build -t $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/weatherreport_app:frontend_v1.0 \
             -f $(git rev-parse --show-toplevel)/frontend/Dockerfile.frontend \
             $(git rev-parse --show-toplevel)/frontend/

docker push $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/weatherreport_app:frontend_v1.0
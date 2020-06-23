aws ecr get-login-password --profile my-profile-name | \
docker login --username AWS --password-stdin $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com

docker build -t $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/weatherreport_app:weatherupdate_v1.0 \
             -f $(git rev-parse --show-toplevel)/weatherupdator/Dockerfile.openWeatherMap \
             $(git rev-parse --show-toplevel)/weatherupdator/

docker push $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/weatherreport_app:weatherupdate_v1.0
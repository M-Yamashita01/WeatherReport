docker-compose down
docker-compose -f docker-compose.yml down

docker-compose build
docker-compose up -d

# MySQLの確実な起動待ちのためにwait-for-it.sh利用
# 開発用とテスト用のデータベースの作成、migrateを行う
docker-compose exec server_latest sh -c '\
curl -O https://raw.githubusercontent.com/vishnubob/wait-for-it/54d1f0bfeb6557adf8a3204455389d0901652242/wait-for-it.sh
chmod +x wait-for-it.sh && \
./wait-for-it.sh -h db_latest -p 3306 -t 60 && \
bundle install && \
bundle exec rake db:create && \
bundle exec rake db:migrate && \
RAILS_ENV=test bundle exec rake db:create && \
RAILS_ENV=test bundle exec rake db:migrate && \
rm wait-for-it.sh'


docker-compose down
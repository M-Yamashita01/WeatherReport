# WeatherReport
緯度、経度は国土地理院の情報を使用
ただし
一部地域は統合等により存在しないものがある。
そのためその地域を含む地域名を使用

地図にはamchartsを使用
ログインにはdeviseを使用

## How to run

必要なパッケージのインストール

```
$ brew install mysql
$ yarn install
```

MySQL起動、database作成

```
$ mysql.server start
$ mysql -u root
mysql> create database weather_report_development;
Query OK, 1 row affected (0.01 sec)
$ bin/rails db:migrate RAILS_ENV=development
```

実行

```shell
$ export MYSQL_USER_DEVELOPMENT=root
$ export MYSQL_PASS_DEVELOPMENT=
$ bundle exec rails s -p 3000
```

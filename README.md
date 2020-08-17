# WeatherReport
日本の天気を表示するWebアプリです。

## 機能一覧
- 日本地図上で全国の天気表示
- 地図上で選択したエリアを拡大、付近の天気を表示
- ログイン、ログアウト
- コメント表示、投稿、ページネーション
- Twitterタイムライン表示
- プロフィール表示、編集

## 使用技術
- フロントエンド
  - Vue.js  
- バックエンド(APIサーバー)
  - Ruby on Rails
- DB
  - MySQL
- 開発環境
  - Docker
  - Docker Compose
- テスト
  - RSpec
- CI
  - Circle CI
- インフラ
  - AWS
    - Route53
    - ALB
    - EKS
    - ECR
    - EC2
    - RDS
  - Terraform

# 構成図
![](https://github.com/M-Yamashita01/WeatherReport/blob/images/WeatherReport.jpg)

## How to run
OpenWeatherMapのAPI Keyを取得します。  
参考記事
[RubyでOpenWeatherMapを使って天気を取得してみた](https://qiita.com/M-Yamashii/items/ba54d7556c58feb3b86a)

cloneしてきた環境に、以下.envファイルを作り、API Keyをセットします。  
```.env
OPENWEATHERMAP_API_KEY=取得したAPIキー
```

docker-composeで起動します。
```
$ docker-compose up --force-recreate --build
```

天気情報はOpenWeatherMapから取得しています。  
db-openweathermapコンテナ内で天気情報を取得し、DBに入れています。


## 補足情報
- 地図にはamchartsを使用
- ログインにはdevise tokenを使用

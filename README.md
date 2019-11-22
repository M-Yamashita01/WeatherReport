# WeatherReport
日本の天気を表示するWebアプリです。

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
地図にはamchartsを使用  
ログインにはdevise tokenを使用

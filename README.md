# What is WeatherReport?
This is web application to display weather in Japan.

There are already various weather web sites, but the functions I want to see are scattered around each site, so I started to make one that I thought would be nice to put together.

# Feature list
- Display the weather for all of Japan.
- If you zoom in on the selected area on the map, you can see the weather in the vicinity.
- You can login and logout.
- You can post a comment, and see the comments in timeline.
- Display the twitter timeline.
- You can see your profile, and edit the profile.

# Framework, Cloud, Tool
- Frontend
  - Vue.js  
- Backend(API Server)
  - Ruby on Rails
- DB
  - MySQL
- Container
  - Docker
  - Docker Compose
- Test
  - RSpec
- CI
  - Circle CI
- Cloud
  - AWS
    - Route53
    - ALB
    - EKS
    - ECR
    - EC2
    - RDS
  - Terraform

# Architecture
![](https://github.com/M-Yamashita01/WeatherReport/blob/images/WeatherReport.jpg)

# How to run

Get the OpenWeatherMap API Key.  
Reference Article.
[RubyでOpenWeatherMapを使って天気を取得してみた](https://qiita.com/M-Yamashii/items/ba54d7556c58feb3b86a)

Create .env file, and write the following .env file. 
```.env
OPENWEATHERMAP_API_KEY=<The above API key>
```

Use following commands, and start WeatherReport application.
```
$ docker-compose -f docker-development.yml build
$ docker-compose -f docker-development.yml up
```

If you access ```localhost:8080```, you can see the WeatherReport application.


# Supplement
- Use amcharts in map.
- Use devise in login process.
- Get the weather data by OpenWeatherMap

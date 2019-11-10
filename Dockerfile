FROM ruby:2.6.5-alpine

# 必要なパッケージのインストール（基本的に必要になってくるものだと思うので削らないこと）
RUN apk update && \
    apk --no-cache add build-base \
                       mysql-dev \
                       curl \
                       bash

# 作業ディレクトリの作成、設定
WORKDIR /weather_report

# MySQLの確実な起動待ちのためにwait-for-it.sh利用
RUN curl -O https://raw.githubusercontent.com/vishnubob/wait-for-it/54d1f0bfeb6557adf8a3204455389d0901652242/wait-for-it.sh && \
    chmod +x wait-for-it.sh

# ホスト側（ローカル）のGemfileを追加する
COPY Gemfile* ./

# Gemfileのbundle install
RUN gem install bundler:2.0.1 && \
    bundle install

COPY . ./
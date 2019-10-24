FROM ruby:2.6.3

# 必要なパッケージのインストール（基本的に必要になってくるものだと思うので削らないこと）
RUN apt-get update -qq  && \
    apt-get install -y  build-essential \
                        libpq-dev \
                        nodejs \
                        curl && \
    curl -sL https://deb.nodesource.com/setup_10.x | bash - && \
    apt-get install -y nodejs

#yarnパッケージ管理インストール
RUN apt-get update && \
    apt-get install -y apt-transport-https wget && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install -y yarn

# 作業ディレクトリの作成、設定
WORKDIR /weather_report

# MySQLの確実な起動待ちのためにwait-for-it.sh利用
RUN curl -O https://raw.githubusercontent.com/vishnubob/wait-for-it/54d1f0bfeb6557adf8a3204455389d0901652242/wait-for-it.sh && \
    chmod +x wait-for-it.sh

# ホスト側（ローカル）のGemfileを追加する（ローカルのGemfileは【３】で作成）
COPY Gemfile ./
COPY Gemfile.lock ./

# Gemfileのbundle install
RUN gem install bundler:2.0.1 && \
    bundle install

COPY . ./
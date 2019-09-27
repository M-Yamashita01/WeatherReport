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
RUN mkdir /weather_report 
##作業ディレクトリ名をAPP_ROOTに割り当てて、以下$APP_ROOTで参照
ENV APP_ROOT /weather_report 
WORKDIR $APP_ROOT

# ホスト側（ローカル）のGemfileを追加する（ローカルのGemfileは【３】で作成）
ADD ./Gemfile $APP_ROOT/Gemfile
ADD ./Gemfile.lock $APP_ROOT/Gemfile.lock

# Gemfileのbundle install
RUN gem install bundler:2.0.1 && \
    bundle install

# packageを追加する
ADD ./package.json $APP_ROOT/package.json
# ADD ./package-lock.json $APP_ROOT/package-lock.json

ADD yarn.lock $APP_ROOT
RUN yarn install

ADD . $APP_ROOT
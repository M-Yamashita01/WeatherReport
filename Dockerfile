# コピペでOK, app_nameもそのままでOK
# 19.01.20現在最新安定版のイメージを取得
FROM ruby:2.6.3

# 必要なパッケージのインストール（基本的に必要になってくるものだと思うので削らないこと）
RUN apt-get update -qq && \
    apt-get install -y build-essential \
                       libpq-dev \
                        curl
#                       nodejs \
#                       npm

# nodejs, npmをインストール
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN apt-get install -y nodejs
RUN npm install npm@latest -g

# nodejs, npmバージョン確認
RUN node -v
RUN npm -v

# 作業ディレクトリの作成、設定
RUN mkdir /weather_report 
##作業ディレクトリ名をAPP_ROOTに割り当てて、以下$APP_ROOTで参照
ENV APP_ROOT /weather_report 
WORKDIR $APP_ROOT

# ホスト側（ローカル）のGemfileを追加する（ローカルのGemfileは【３】で作成）
ADD ./Gemfile $APP_ROOT/Gemfile
ADD ./Gemfile.lock $APP_ROOT/Gemfile.lock

# Gemfileのbundle install
RUN gem install bundler:2.0.1
RUN bundle install

# packageを追加する
ADD ./package.json $APP_ROOT/package.json
ADD ./package-lock.json $APP_ROOT/package-lock.json

# npmパッケージをインストール
RUN npm install
ADD . $APP_ROOT
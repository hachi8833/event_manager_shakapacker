# README


```sh
# Docker環境セットアップ
dip bundle install
```

```sh
# Railsバージョン確認
dip rails -v
```

```sh
# esbuildの場合
dip rails new . -j esbuild
```

以後の操作も、コマンド冒頭に`dip`を付ける点だけが異なります。

```sh
# 例
dip bundle add shakapacker --strict
```

なお、`yarn`は既にセットアップに含まれているので、以下は実行不要です。

```sh
# 実行不要
npm i -g yarn
```

## Shakapackerの場合

現在のセットアップはShakapackerに対応していません。

* Webpacker用のcompose.ymlにする
* compose.ymlの48行目を`command: bin/rails s`に変更する
* webpacker.ymlファイルを手動で生成する

```sh
# （エラー回避用）
touch app/config/webpacker.yml
```

```yaml
x-app: &app
  build:
    context: .
    args:
      RUBY_VERSION: '3.1.2'
      NODE_MAJOR: '16'
      YARN_VERSION: '1.22.17'
  image: rails7_react_crud_tutorial:1.0.0
  environment: &env
    NODE_ENV: ${NODE_ENV:-development}
    RAILS_ENV: ${RAILS_ENV:-development}
  tmpfs:
    - /tmp
    - /app/tmp/pids

x-backend: &backend
  <<: *app
  stdin_open: true
  tty: true
  volumes:
    - ..:/app:cached
    - bundle:/usr/local/bundle
    - rails_cache:/app/tmp/cache
    - assets:/app/public/assets
    - assets_builds:/app/assets/builds
    - node_modules:/app/node_modules
    - packs:/app/public/packs
    - packs-test:/app/public/packs-test
    - history:/usr/local/hist
    - ./.psqlrc:/root/.psqlrc:ro
    - ./.bashrc:/root/.bashrc:ro
    - ./.irbrc:/root/.irbrc:ro
  environment: &backend_environment
    <<: *env
    RUBY_YJIT_ENABLE: 1
    MALLOC_ARENA_MAX: 2
    WEB_CONCURRENCY: ${WEB_CONCURRENCY:-1}
    BOOTSNAP_CACHE_DIR: /usr/local/bundle/_bootsnap
    XDG_DATA_HOME: /app/tmp/caches
    BINDING: 0.0.0.0
    HISTFILE: /usr/local/hist/.bash_history
    IRB_HISTFILE: /usr/local/hst/.irb_history
    EDITOR: vi
    WEBPACKER_DEV_SERVER_HOST: webpacker
    YARN_CACHE_FOLDER: /app/node_modules/.yarn-cache

services:
  rails:
    <<: *backend
    command: bundle exec rails

  web:
    <<: *backend
    command: bin/rails s
    ports:
      - '3000:3000'
      - '35729:35729'
    depends_on:
      webpacker:
        condition: service_started

  webpacker:
    <<: *app
    command: bundle exec ./bin/webpack-dev-server
    ports:
      - '3035:3035'
    volumes:
      - ..:/app:cached
      - bundle:/usr/local/bundle
      - node_modules:/app/node_modules
      - packs:/app/public/packs
      - packs-test:/app/public/packs-test
    environment:
      <<: *env
      WEBPACKER_DEV_SERVER_HOST: 0.0.0.0
      YARN_CACHE_FOLDER: /app/node_modules/.yarn-cache

volumes:
  bundle:
  history:
  rails_cache:
  assets:
  assets_builds:
  node_modules:
  packs:
  packs-test:
```

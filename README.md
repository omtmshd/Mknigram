**概要**

ヴィーガン・ベジタリアン向けの料理を投稿、共有するアプリケーションです。
菜食主義者の方向けのレシピ投稿サービスには需要が高まってきていると思い、作成いたしました。
![スクショ](https://user-images.githubusercontent.com/67169292/94879118-4b50e700-049a-11eb-8459-e114e8ba7c20.png)
![スクショ](https://user-images.githubusercontent.com/67169292/94879121-50159b00-049a-11eb-9a20-ab98a0362478.png)

**主な使用技術**

- ruby 2.6.6
- Rails 6.0.3
- MySQL
- Vue.js ( SPA化 )
- Vuetify
- RSpec, FactoryBot ( テスト )
- AWS(EC2 / ALB / Route53 / ACM / RDS / VPC / S3 )
- Docker,docker-compose( 開発環境 )


**機能一覧**

- ユーザー・ログイン機能( devise, devise_token_auth )
- フォロー機能
- レシピ投稿機能
- 画像アップロード機能( carrierwave )
- いいね機能
- カテゴリー機能( ancestry )
- マイリスト機能
- 無限スクロール機能( vue-infinite-loading )

**その他使用したライブラリ**

- VueRouter ( ルーティング ) 
- ActiveAdmin ( 管理画面 )
- RuboCop
- Axios
- rails-i18n

**インフラ構成図**

![Untitled Diagram](https://user-images.githubusercontent.com/67169292/93694995-19ac5780-fb4d-11ea-8360-f7b09296f7f1.png)

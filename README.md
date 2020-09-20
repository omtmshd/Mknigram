**概要**

レシピを投稿、共有するアプリケーションです。
![スクショ](https://user-images.githubusercontent.com/67169292/93557425-ea171700-f9b5-11ea-8d44-934c56e40c65.png)

**機能一覧**

- ユーザー・ログイン機能( devise_token_auth )
- レシピ投稿機能
- 画像アップロード機能( carrierwave )
- いいね機能
- カテゴリー機能( ancestry )
- 無限スクロール機能( vue-infinite-loading )


**主な使用技術**

- ruby '2.6.6'
- Rails '6.0.3'
- MySQL
- Vue.js ( SPA化 )
- Vuetify
- RSpec
- AWS(EC2 / ALB / Route53 / ACM / RDS / VPC / S3 )
- Docker,docker-compose( 開発環境 )

**インフラ構成図**

![Untitled Diagram](https://user-images.githubusercontent.com/67169292/93694995-19ac5780-fb4d-11ea-8360-f7b09296f7f1.png)

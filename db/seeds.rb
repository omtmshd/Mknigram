# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)



categories = [
  { level1: 'お店', level1_children: [
    { level2: '和食のお店', level2_children: ['定食屋', '寿司屋', '料亭','割烹料理 店','天ぷら屋','蕎麦屋','ラーメン屋'] },
    { level2: 'アジア料理 店', level2_children: ['インド料理 店','ベトナム料理 店','韓国料理 店','タイ料理 店', '中華料理 店'] },
    { level2: 'ヨーロッパ料理 店', level2_children: ['イタリア料理 店', 'フランス料理 店','スペイン料理 店'] },
    { level2: 'お肉料理屋', level2_children: ['焼肉屋', 'ステーキ屋','鉄板焼き 店','しゃぶしゃぶ 店','すき焼き 店','串焼き屋'] },
    { level2: 'カフェ・スイーツ', level2_children: ['パン屋', 'ケーキ屋','カフェ','喫茶店','サンドイッチ 店'] },
    { level2: 'ファミレス・ファストフード'},
    { level2: '居酒屋・バー'}
  ] },
  { level1: '食材', level1_children: [
    { level2: '野菜', level2_children: ['アスパラガス', 'かぼちゃ','キノコ','キャベツ','ごぼう','さつまいも','じゃがいも','たまねぎ','だいこん','トマト','なす','にんじん','ねぎ','その他 野菜'] },
    { level2: 'お肉', level2_children: ['牛肉', '豚肉', 'とり肉', '羊肉', 'ベーコン', 'ハム', 'ソーセージ', 'その他 肉'] },
    { level2: '魚介', level2_children: ['アジ', 'イワシ', 'サバ', 'サケ', 'イカ', 'エビ', 'タコ', 'ちりめん・しらす', '海藻類','貝', 'その他 魚介'] },
    { level2: '豆腐・納豆・漬物', level2_children: ['豆腐', '納豆', 'キムチ', '漬物'] },
    { level2: '卵・チーズ・乳製品', level2_children: ['チーズ', 'ヨーグルト', '牛乳', '生クリーム', 'バター', '鶏卵', 'その他 乳製品'] },
    { level2: '粉類', level2_children: ['小麦粉', 'パン粉','片栗粉'] },
    { level2: 'フルーツ', level2_children: ['みかん・柑橘', 'メロン', 'マンゴー', 'イチゴ', 'バナナ', 'レモン', 'りんご', 'その他 フルーツ'] }
  ] },
  { level1: '定番まかない飯', level1_children: [
    { level2: '丼ぶり', level2_children: ['親子丼', 'カツ丼', '海鮮丼', '天丼', 'その他 丼ぶり'] },
    { level2: 'カレー', level2_children: ['ルウカレー', 'スープカレー','インドカレー','タイカレー'] },
    { level2: 'パスタ料理', level2_children: ['トマト系パスタ', 'オイル系パスタ', 'クリーム系パスタ', 'ジェノベーゼ'] },
    { level2: '麺', level2_children: ['うどん', 'そうめん', 'そば', 'パスタ', 'ラーメン', '焼きそば'] },
    { level2: '炒め物'},
    { level2: 'チャーハン'},
    { level2: 'グラタン・ドリア'}
  ] },
  { level1: 'おやつ', level1_children: [
    { level2: 'パン', level2_children: ['食パン', '菓子パン', '惣菜パン', 'クロワッサン', 'その他 パン'] },
    { level2: '洋菓子', level2_children: ['クッキー', 'チョコレート', 'ケーキ', 'タルト・パイ', 'ドーナツ', 'その他 洋菓子'] },
    { level2: '和菓子', level2_children: ['団子', 'まんじゅう','おしるこ'] }
  ] },
  { level1: 'ドリンク', level1_children: [
    { level2: 'ソフトドリンク', level2_children: ['フルーツジュース', '炭酸', '野菜ジュース', 'チョコレートドリンク', 'その他ソフトドリンク'] },
    { level2: 'お茶', level2_children: ['日本茶', '紅茶', 'ハーブティー'] },
    { level2: 'コーヒー・ココア', level2_children: ['ホットコーヒー', 'アイスコーヒー','アレンジコーヒー','ココア'] },
    { level2: 'お酒', level2_children: ['ビール', '焼酎','日本酒','梅酒','ワイン','ウイスキー'] }
  ] }
]

categories.each.with_index(1) do |category, i|
  level1_var = "@category#{i}" # 1階層の変数
  level1_val = Category.create(name: (category[:level1]).to_s) # 1階層の値作成
  eval("#{level1_var} = level1_val")                                                # 1階層の変数=1階層の値
  category[:level1_children].each.with_index(1) do |level1_child, j|
    level2_var = "#{level1_var}_#{j}"                                               # 2階層の変数
    level2_val = eval("#{level1_var}.children.create(name:level1_child[:level2])") # 2階層の値作成
    eval("#{level2_var} = level2_val") # 2階層の変数=2階層の値
    # 3階層の値作成
    level1_child[:level2_children]&.each do |level2_children_val|
      eval("#{level2_var}.children.create(name:level2_children_val)") # 3階層の値作成
    end
  end
end


if Rails.env == 'development'
  100.times do |n|
    name  = "example-#{n + 1}"
    email = "example-#{n + 1}@example.com"
    password = 'password'
    user = User.create!(
      name: name,
      email: email,
      profile: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus venenatis aliquet leo, quis elementum enim hendrerit eu. Donec blandit velit sed orc.',
      password: password,
      password_confirmation: password
    )
    title = "カレー#{n + 1}"
    body = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse non ultrices ipsum, aliquet tempor velit. In ut consectetur est, et vehicula tellus. Duis feugiat leo ligula, eget porta mi tristique sit amet. Mauris rhoncus ultrices augue id.'
    user.posts.create(
      title: title,
      body: body,
      post_image: open("#{Rails.root}/db/fixtures/img.jpg"),
      category_ids: [3, 4, 5]
    )
  end

  users = User.all
  user  = users.first
  following = users[2..50]
  followers = users[3..40]
  following.each { |followed| user.follow(followed) }
  followers.each { |follower| follower.follow(user) }

end

User.create!(name:  "管理者",
  email: ENV['ADMIN_EMAIL'],
  password:  ENV['ADMIN_PASSWORD'],
  password_confirmation: ENV['ADMIN_PASSWORD'],
  admin: true)

User.create!(name:  "テストユーザー",
  email: "test@gmail.com",
  password: "password",
  password_confirmation: "password")


# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)



categories = [
  { level1: '野菜', level1_children: [
    { level2: 'よく使う野菜', level2_children: %w[にんじん じゃがいも たまねぎ キャベツ] },
    { level2: '春野菜', level2_children: %w[たけのこ アスパラガス 山菜 クレソン グリンピース さやえんどう そら豆 新たまねぎ 新じゃがいも アボカド レタス 菜の花 スナップエンドウ ふき] },
    { level2: '夏野菜', level2_children: %w[とうもろこし きゅうり ピーマン さやいんげん オクラ 枝豆 ゴーヤ ズッキーニ 冬瓜 トマト モロヘイヤ なす かぼちゃ みょうが パプリカ ししとう 新生姜] },
    { level2: '秋/冬野菜', level2_children: ['大根', '白菜', '水菜', '里芋', 'さつまいも', '長芋/山芋', 'れんこん', 'ブロッコリー', 'チンゲン菜', 'セロリ', 'かぶ', '小松菜', 'ごぼう', 'カリフラワー', '長ねぎ', 'ほうれん草', '春菊'] },
    { level2: 'きのこ', level2_children: %w[しいたけ しめじ まいたけ エノキ マッシュルーム エリンギ なめこ] },
    { level2: '豆類', level2_children: %w[ミックスビーンズ 黒豆 ひよこ豆 大豆 レンズ豆] }
  ] },
  { level1: '肉料理', level1_children: [
    { level2: '牛肉', level2_children: ['ローストビーフ', 'ビーフステーキ', '牛薄切り肉/牛こま切れ肉', '牛かたまり肉'] },
    { level2: '豚肉', level2_children: ['豚の角煮', '豚の生姜焼き', 'スペアリブ', 'チャーシュー/煮豚', '酢豚', '豚バラ肉', '豚こま切れ肉', '豚薄切り肉', '豚かたまり肉'] },
    { level2: '鶏肉', level2_children: %w[鶏の唐揚げ ローストチキン 照り焼きチキン 鶏もも肉 鶏むね肉 鶏ささみ 鶏手羽] },
    { level2: '挽き肉', level2_children: ['つくね', 'ハンバーグ', '餃子/シュウマイ', '豚まん/肉まん', '春巻き'] },
    { level2: 'ソーセージ' },
    { level2: 'ハム' },
    { level2: 'ベーコン', level2_children: ['自家製ベーコン/パンチェッタ', 'ベーコンを使った料理'] },
    { level2: 'モツ', level2_children: ['レバー', 'ホルモン', '砂肝' ] }
  ] },
  { level1: '魚介料理', level1_children: [
    { level2: '魚', level2_children: ['鮭/サーモン', 'いわし', 'さば', 'あじ'、'ぶり'、'さんま'、'鯛'、'マグロ'、'その他お魚'] }
    { level2: '海老' },
    { level2: 'イカ' },
    { level2: 'たこ' },
    { level2: '貝類' },
    { level2: '蟹' },
    { level2: 'ツナ缶' },
    { level2: '練り物' }
  ] },
  { level1: 'ごはんもの', level1_children: [
    { level2: '丼もの', level2_children: %w[カツ丼 天丼 牛丼 中華丼 親子丼 海鮮丼 アレンジ丼] },
    { level2: 'カレー', level2_children: %w[チキンカレー ポークカレー 野菜カレー ビーフカレー タイ風カレー インド風カレー ドライカレー スープカレー] },
    { level2: 'オムライス' },
    { level2: '寿司' },
    { level2: '炒めご飯/チャーハン' },
    { level2: '炊き込み/まぜご飯'},
    { level2: 'リゾット/雑炊類'}
  ] },
  { level1: 'パスタ/グラタン', level1_children: [
    { level2: 'トマト系パスタ', level2_children: ['ペスカトーレ', 'ミートソース', 'トマトクリーム', 'ボンゴレロッソ', 'ナポリタン', 'アラビアータ', 'トマトソースパスタ'] },
    { level2: 'クリーム系パスタ', level2_children: %w[クリームソース カルボナーラ] },
    { level2: 'オイル/塩系パスタ', level2_children: ['ペペロンチーノ', 'ボンゴレビアンコ', 'アレンジオイル/塩系パスタ'] },
    { level2: 'チーズ系パスタ' },
    { level2: 'ジェノベーゼ' },
    { level2: '和風パスタ' },
    { level2: '冷製パスタ' },
    { level2: 'スープパスタ' },
    { level2: 'ニョッキ' },
    { level2: 'グラタン' },
    { level2: 'ラザニア/ラビオリ' },
    { level2: '手作りパスタ' }
  ] },
  { level1: '麺', level1_children: [
    { level2: 'うどん' },
    { level2: '蕎麦' },
    { level2: 'そうめん' },
    { level2: 'ラーメン' },
    { level2: '焼きそば' },
    { level2: '冷やし中華' },
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
      category_ids: [1, 2, 3]
    )
  end

  users = User.all
  user  = users.first
  following = users[2..50]
  followers = users[3..40]
  following.each { |followed| user.follow(followed) }
  followers.each { |follower| follower.follow(user) }

end
if Rails.env == 'production'
end

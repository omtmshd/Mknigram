# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
if Rails.env == 'development'

  100.times do |n|
    name  = "example-#{n+1}"
    email = "example-#{n+1}@example.com"
    password = "password"
    user = User.create!(
                name:  name,
                email: email,
                password:              password,
                password_confirmation: password)
    title = "カレー#{n+1}"
    body = "a" * 250
    user.posts.create(
                title: title,
                body: body,
                post_image: open("#{Rails.root}/db/fixtures/img.jpg"))
  end

  vegetable = Category.create(name: "野菜料理")
    major = vegetable.children.create(name: "よく使う野菜")
      major.children.create([{name: "にんじん"}, {name: "じゃがいも"}, {name: "たまねぎ"}, {name: "キャベツ"}])
    spring = vegetable.children.create(name: "旬野菜　春")
      spring.children.create([{name: "たけのこ"}, {name: "アスパラガス"}, {name: "山菜"}, {name: "クレソン"}, {name: "グリンピース"}, {name: "さやえんどう"}, {name: "そら豆"}, {name: "新たまねぎ"}, {name: "新じゃがいも"}, {name: "アボカド"}, {name: "レタス"}, {name: "菜の花"}, {name: "スナップエンドウ"}, {name: "ふき"}])
    summer = vegetable.children.create(name: "旬野菜　夏")
      summer.children.create([{name: "とうもろこし"}, {name: "きゅうり"}, {name: "ピーマン"}, {name: "さやいんげん"}, {name: "オクラ"}, {name: "枝豆"}, {name: "ゴーヤ"}, {name: "ズッキーニ"}, {name: "冬瓜"}, {name: "トマト"}, {name: "モロヘイヤ"}, {name: "なす"}, {name: "かぼちゃ"}, {name: "みょうが"}, {name: "パプリカ"}, {name: "ししとう"}, {name: "新生姜"}])
    autumn = vegetable.children.create(name: "旬野菜　秋・冬")
      autumn.children.create([{name: "大根"}, {name: "白菜"}, {name: "水菜"}, {name: "里芋"}, {name: "さつまいも"}, {name: "長芋・山芋"}, {name: "れんこん"}, {name: "ブロッコリー"}, {name: "チンゲン菜"}, {name: "セロリ"}, {name: "かぶ"}, {name: "小松菜"}, {name: "ごぼう"}, {name: "カリフラワー"}, {name: "長ねぎ"}, {name: "ほうれん草"}, {name: "春菊"}])
    mushroom = vegetable.children.create(name: "きのこ")
      mushroom.children.create([{name: "しいたけ"}, {name: "しめじ"}, {name: "まいたけ"}, {name: "エノキ"}, {name: "マッシュルーム"}, {name: "エリンギ"}, {name: "なめこ"}])
    beans = vegetable.children.create(name: "豆類")
      beans.children.create([{name: "ミックスビーンズ"}, {name: "黒豆"}, {name: "ひよこ豆"}, {name: "大豆"}, {name: "レンズ豆"}])
    minor = vegetable.children.create(name: "脇役野菜")
      minor.children.create([{name: "にんにくの芽"}, {name: "ラディッシュ"}, {name: "もやし"}, {name: "ヤーコン"}, {name: "むかご"}, {name: "ニラ"}, {name: "小ねぎ・葉ねぎ"}, {name: "芽キャベツ"}, {name: "大葉"}])

  meat = Category.create(name: "肉料理")
    beef = meat.children.create(name: "牛肉")
      beef.children.create([{name: "ローストビーフ"}, {name: "ビーフステーキ"}, {name: "牛薄切り肉・牛こま切れ肉"}, {name: "牛かたまり肉"}])
    pork = meat.children.create(name: "豚肉")
      pork.children.create([{name: "豚の角煮"}, {name: "豚の生姜焼き"}, {name: "スペアリブ"}, {name: "チャーシュー・煮豚"}, {name: "酢豚"}, {name: "豚バラ肉"}, {name: "豚こま切れ肉"}, {name: "豚薄切り肉"}, {name: "豚かたまり肉"}])
    chicken = meat.children.create(name: "鶏肉")
      chicken.children.create([{name: "鶏の唐揚げ"}, {name: "ローストチキン"}, {name: "照り焼きチキン"}, {name: "鶏もも肉"}, {name: "鶏むね肉"}, {name: "鶏ささみ"}, {name: "鶏手羽"}])
    minced = meat.children.create(name: "挽き肉")
      minced.children.create([{name: "つくね"}, {name: "ハンバーグ"}, {name: "餃子・シュウマイ"}, {name: "豚まん・肉まん"}, {name: "牛挽き肉"}, {name: "豚挽き肉"}, {name: "あい挽き肉"}, {name: "鶏挽き肉"}, {name: "ロールキャベツ"}, {name: "春巻き"}])
    sausage = meat.children.create(name: "ソーセージ")
      sausage.children.create([{name: "手作りソーセージ"}, {name: "ソーセージを使った料理"}])
    ham = meat.children.create(name: "ハム")
      ham.children.create([{name: "手作り！自家製ハム"}, {name: "ハムを使った料理"}])
    bacon = meat.children.create(name: "ベーコン")
      bacon.children.create([{name: "自家製ベーコン・パンチェッタ"}, {name: "ベーコンを使った料理"}])
    lamb = meat.children.create(name: "ラム肉")
    motsu = meat.children.create(name: "モツ")
      motsu.children.create([{name: "レバー"}, {name: "ホルモン"}, {name: "砂肝"}, {name: "モツ鍋・モツ煮"}])
  fish = Category.create(name: "魚料理")
  rice = Category.create(name: "ごはんもの")
  pasta = Category.create(name: "パスタ・グラタン")
  noodle = Category.create(name: "麺")
  soup = Category.create(name: "汁物・スープ")
  salad = Category.create(name: "サラダ")
  fried_food = Category.create(name: "揚げ物")
  nabe = Category.create(name: "鍋料理")
  flour = Category.create(name: "粉もの")
  bread = Category.create(name: "パン")
  egg = Category.create(name: "たまご・大豆加工品")
  seaweed = Category.create(name: "海藻・乾物・こんにゃく")
  other = Category.create(name: "その他")

end
if Rails.env == 'production'
end

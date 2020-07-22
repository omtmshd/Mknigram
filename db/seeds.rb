# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

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
      post_image: open("#{Rails.root}/db/fixtures/img.jpg")
    )
  end

  users = User.all
  user  = users.first
  following = users[2..50]
  followers = users[3..40]
  following.each { |followed| user.follow(followed) }
  followers.each { |follower| follower.follow(user) }

  categories = [
    { level1: '野菜料理', level1_children: [
      { level2: 'よく使う野菜', level2_children: %w[にんじん じゃがいも たまねぎ キャベツ] },
      { level2: '旬野菜　春', level2_children: %w[たけのこ アスパラガス 山菜 クレソン グリンピース さやえんどう そら豆 新たまねぎ 新じゃがいも アボカド レタス 菜の花 スナップエンドウ ふき] },
      { level2: '旬野菜　夏', level2_children: %w[とうもろこし きゅうり ピーマン さやいんげん オクラ 枝豆 ゴーヤ ズッキーニ 冬瓜 トマト モロヘイヤ なす かぼちゃ みょうが パプリカ ししとう 新生姜] },
      { level2: '旬野菜　秋・冬', level2_children: ['大根', '白菜', '水菜', '里芋', 'さつまいも', '長芋・山芋', 'れんこん', 'ブロッコリー', 'チンゲン菜', 'セロリ', 'かぶ', '小松菜', 'ごぼう', 'カリフラワー', '長ねぎ', 'ほうれん草', '春菊'] },
      { level2: 'きのこ', level2_children: %w[しいたけ しめじ まいたけ エノキ マッシュルーム エリンギ なめこ] },
      { level2: '豆類', level2_children: %w[ミックスビーンズ 黒豆 ひよこ豆 大豆 レンズ豆] },
      { level2: '脇役野菜', level2_children: %w[にんにくの芽 ラディッシュ もやし ヤーコン むかご ニラ 小ねぎ葉ねぎ 芽キャベツ 大葉] }
    ] },
    { level1: '肉料理', level1_children: [
      { level2: '牛肉', level2_children: ['ローストビーフ', 'ビーフステーキ', '牛薄切り肉・牛こま切れ肉', '牛かたまり肉'] },
      { level2: '豚肉', level2_children: ['豚の角煮', '豚の生姜焼き', 'スペアリブ', 'チャーシュー・煮豚', '酢豚', '豚バラ肉', '豚こま切れ肉', '豚薄切り肉', '豚かたまり肉'] },
      { level2: '鶏肉', level2_children: %w[鶏の唐揚げ ローストチキン 照り焼きチキン 鶏もも肉 鶏むね肉 鶏ささみ 鶏手羽] },
      { level2: '挽き肉', level2_children: ['つくね', 'ハンバーグ', '餃子・シュウマイ', '豚まん・肉まん', '牛挽き肉', '豚挽き肉', 'あい挽き肉', '鶏挽き肉', 'ロールキャベツ', '春巻き'] },
      { level2: 'ソーセージ', level2_children: %w[手作りソーセージ ソーセージを使った料理] },
      { level2: 'ハム', level2_children: %w[手作り自家製ハム ハムを使った料理] },
      { level2: 'ベーコン', level2_children: ['自家製ベーコン・パンチェッタ', 'ベーコンを使った料理'] },
      { level2: 'ラム肉' },
      { level2: 'モツ', level2_children: ['レバー', 'ホルモン', '砂肝', 'モツ鍋・モツ煮'] }
    ] },
    { level1: '魚料理', level1_children: [
      { level2: '鮭・サーモン' },
      { level2: 'いわし' },
      { level2: 'さば' },
      { level2: 'あじ' },
      { level2: 'ぶり' },
      { level2: 'さんま' },
      { level2: '鯛' },
      { level2: 'マグロ' },
      { level2: 'その他お魚' },
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
      { level2: 'カレー', level2_children: %w[チキンカレー ポークカレー 野菜カレー ビーフカレー タイ風カレー 挽き肉を使ったカレー インド風カレー ルウから作るカレー ドライカレー スープカレー] },
      { level2: 'オムライス', level2_children: ['デミ・ブラウンソースオムライス', 'プレーンなオムライス', 'クリームソースオムライス', 'アレンジオムライス'] },
      { level2: '寿司', level2_children: ['ちらし寿司', '握り寿司', '押し寿司', '巻き寿司', 'いなり寿司', '寿司飯の作り方', 'お祝い・パーティー寿司'] },
      { level2: '炒めご飯・チャーハン', level2_children: %w[あんかけチャーハン 海鮮チャーハン お漬物を使ったチャーハン 納豆チャーハン アレンジ炒めご飯 ナシゴレン] },
      { level2: '炊き込み・まぜご飯', level2_children: %w[炊き込みご飯 まぜご飯 おこわ ピラフ パエリア ビビンバ] },
      { level2: 'リゾット・雑炊類', level2_children: ['リゾット', '雑炊・おじや', 'お粥', 'クッパ'] },
      { level2: 'アレンジごはん', level2_children: %w[おにぎり 焼きおにぎり ドリア ライスコロッケ お茶漬け] }
    ] },
    { level1: 'パスタ・グラタン', level1_children: [
      { level2: 'トマト系パスタ', level2_children: ['ペスカトーレ', 'ミートソース', 'トマトクリーム', 'ボンゴレ・ロッソ', 'ナポリタン', 'アラビアータ', 'トマトソースパスタ'] },
      { level2: 'クリーム系パスタ', level2_children: %w[クリームソース カルボナーラ] },
      { level2: 'オイル・塩系パスタ', level2_children: ['ペペロンチーノ', 'ボンゴレ・ビアンコ', 'アレンジオイル・塩系パスタ'] },
      { level2: 'チーズ系パスタ' },
      { level2: 'ジェノベーゼ' },
      { level2: '和風パスタ', level2_children: ['明太子・たらこスパ', '醤油風味スパ', '味噌風味スパ', '梅風味スパ', '納豆入りスパ'] },
      { level2: '冷製・アイデアパスタ', level2_children: %w[冷製パスタ アイデアパスタ] },
      { level2: 'スープパスタ' },
      { level2: 'ニョッキ' },
      { level2: 'グラタン', level2_children: %w[カボチャグラタン マカロニグラタン 魚介のグラタン チキングラタン 豆腐グラタン アレンジグラタン ポテトグラタン] },
      { level2: 'ラザニア・ラビオリ', level2_children: ['ラザニア', 'ラビオリ', 'アイデアラザニア・ラビオリ'] },
      { level2: '手作りパスタ' }
    ] },
    { level1: '麺', level1_children: [
      { level2: 'うどん', level2_children: %w[サラダうどん 煮込みうどん カレーうどん 焼うどん ほうとう アレンジうどん 冷やしうどん] },
      { level2: '蕎麦', level2_children: %w[温かい蕎麦 冷たい蕎麦 蕎麦寿司 アレンジ蕎麦] },
      { level2: 'そうめん', level2_children: %w[そうめんチャンプルー にゅうめん アレンジそうめん] },
      { level2: '中華麺', level2_children: %w[焼きそば ラーメン アレンジ焼きそば ジャージャー麺 冷やし中華] },
      { level2: 'アジアの麺', level2_children: ['ビーフン', 'フォー', 'ビビン麺・冷麺'] },
      { level2: '手打ち麺', level2_children: ['手打ちうどん', '手打ち蕎麦・中華麺'] }
    ] },
    { level1: '汁物・スープ', level1_children: [
      { level2: 'お味噌汁' },
      { level2: 'お吸い物' },
      { level2: 'けんちん汁' },
      { level2: '豚汁' },
      { level2: '中華スープ' },
      { level2: 'シチュー', level2_children: %w[ビーフシチュー クリームシチュー アレンジシチュー] },
      { level2: 'クリームスープ' },
      { level2: 'トマトスープ' },
      { level2: 'コーンスープ' },
      { level2: 'チャウダー' },
      { level2: 'ビシソワーズ' },
      { level2: 'ガスパチョ' },
      { level2: 'ミネストローネ' },
      { level2: '冷や汁' },
      { level2: 'ポタージュ' },
      { level2: 'オニオングラタンスープ' },
      { level2: 'エスニックなスープ', level2_children: ['タイ風・アジアンスープ', '韓国風スープ'] },
      { level2: 'コンソメスープ' },
      { level2: 'ラタトゥイユ' }
    ] },
    { level1: 'サラダ', level1_children: [
      { level2: '和風のサラダ' },
      { level2: '洋風のサラダ' },
      { level2: '中華風のサラダ' },
      { level2: 'あったかいサラダ' },
      { level2: 'イタリアンサラダ' },
      { level2: '韓国風のサラダ' },
      { level2: 'アジアンサラダ' },
      { level2: 'マヨネーズ系のサラダ' },
      { level2: 'バルサミコ酢を使ったサラダ' },
      { level2: 'ナンプラーを使ったサラダ' },
      { level2: '魚介のサラダ' },
      { level2: 'お肉を使ったサラダ' },
      { level2: 'ツナを使ったサラダ' },
      { level2: '海藻のサラダ' },
      { level2: '豆腐のサラダ' },
      { level2: 'トマトのサラダ' },
      { level2: 'ゴーヤのサラダ' },
      { level2: 'カボチャのサラダ' },
      { level2: 'ポテトサラダ' },
      { level2: 'コールスローサラダ' },
      { level2: '生春巻き' }
    ] },
    { level1: 'コロッケ・メンチカツ', level1_children: [
      { level2: 'ポテトコロッケ' },
      { level2: 'クリームコロッケ' },
      { level2: 'さつまいもコロッケ' },
      { level2: '里芋コロッケ' },
      { level2: 'おからコロッケ' },
      { level2: 'いろんなコロッケ' },
      { level2: 'メンチカツ' }
    ] },
    { level1: '鍋料理', level1_children: [
      { level2: 'おでん' },
      { level2: '寄せ鍋' },
      { level2: 'ちゃんこ鍋' },
      { level2: '豆乳鍋' },
      { level2: 'もつ鍋' },
      { level2: 'チゲ鍋・キムチ鍋' },
      { level2: 'みぞれ鍋(雪見鍋)' },
      { level2: '郷土鍋', level2_children: %w[石狩鍋 きりたんぽ鍋 水吹き] },
      { level2: 'アイデア鍋', level2_children: %w[蒸し鍋 トマト鍋 カレー鍋 その他アイデア鍋] },
      { level2: 'しゃぶしゃぶ' }
    ] },
    { level1: '粉もの', level1_children: [
      { level2: 'たこ焼き' },
      { level2: 'チヂミ' },
      { level2: 'お好み焼き', level2_children: %w[広島風お好み焼き 関西風お好み焼き アレンジお好み焼き] }
    ] },
    { level1: 'たまご・大豆加工品', level1_children: [
      { level2: 'たまご', level2_children: ['オムレツ', '卵焼き', '温泉たまご・味付けたまご', '茶碗蒸し', 'アレンジたまご料理'] },
      { level2: '豆腐', level2_children: ['揚げ出し豆腐', '麻婆豆腐', '豆腐ハンバーグ', '冷奴', '胡麻豆腐・たまご豆腐', 'アレンジ豆腐料理'] },
      { level2: 'おから' },
      { level2: '豆乳' },
      { level2: '高野豆腐' },
      { level2: '納豆' },
      { level2: '湯葉' },
      { level2: '油揚げ' },
      { level2: '厚揚げ' }
    ] },
    { level1: '海藻・乾物・こんにゃく', level1_children: [
      { level2: 'こんにゃく' },
      { level2: '糸こんにゃく・しらたき' },
      { level2: '海藻', level2_children: %w[わかめ 昆布 ひじき めかぶ] },
      { level2: '乾物', level2_children: ['干ししいたけ', '切り干し大根', '春雨', '桜えび・干しえび', 'きくらげ'] }
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

end
if Rails.env == 'production'
end

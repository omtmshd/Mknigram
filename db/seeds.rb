# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)



categories = [
  { level1: '野菜', level1_children: [
    { level2: '年中出回る食材', level2_children: ['たまねぎ', 'にんじん', 'じゃがいも', 'キャベツ', '大根', 'ピーマン', 'エリンギ', '豆苗', 'もやし', '大葉'] },
    { level2: '春の旬素材', level2_children: ['たけのこ', 'アスパラ', '山菜', 'クレソン', 'グリーンピース', 'さやえんどう', 'そら豆', 'レタス', '菜の花'] },
    { level2: '夏の旬素材', level2_children: ['とうもろこし', 'きゅうり', 'オクラ', '枝豆', 'トマト', 'ゴーヤ', 'なす', 'かぼちゃ', 'みょうが'] },
    { level2: '秋・冬の旬素材', level2_children: ['白菜', '水菜', '里芋', 'さつまいも', 'ブロッコリー', 'かぶ', 'セロリ', '小松菜', '長ネギ', 'ほうれん草', '小松菜'] }
  ] },
  { level1: 'フルーツ', level1_children: [
    { level2: 'バナナ' },
    { level2: 'オレンジ・柑橘' },
    { level2: 'りんご' },
    { level2: 'レモン' },
    { level2: 'ベリー類' },
    { level2: 'パイナップル' }
  ] },
  { level1: '大豆加工品', level1_children: [
    { level2: '豆乳' },
    { level2: '納豆' },
    { level2: '大豆' },
    { level2: '豆乳' }
  ] },
  { level1: 'ご飯もの・丼', level1_children: [
    { level2: '丼ぶり' },
    { level2: 'チャーハン' },
    { level2: 'リゾット' },
    { level2: 'カレー' }
  ] },
  { level1: 'おかず', level1_children: [
    { level2: '炒め物' },
    { level2: '揚げ物', level2_children: ['カツ・フライ', '天ぷら', '素揚げ'] },
    { level2: '和え物' },
    { level2: '蒸し物' },
    { level2: '煮物' },
    { level2: 'ステーキ・ハンバーグ' },
    { level2: 'グリル' },
    { level2: 'その他おかず' }
  ] },
  { level1: 'サラダ', level1_children: [
    { level2: 'ポテトサラダ' },
    { level2: '野菜サラダ' },
    { level2: 'おからサラダ' },
    { level2: 'マリネ' },
    { level2: 'コールスロー' },
    { level2: '自家製ドレッシング' },
    { level2: 'その他サラダ' }
  ] },
  { level1: 'スープ', level1_children: [
    { level2: 'ポタージュ' },
    { level2: 'トマトスープ' },
    { level2: '汁物' }
  ] },
  { level1: 'パスタ', level1_children: [
    { level2: 'トマトソース' },
    { level2: 'クリームソース' },
    { level2: 'ジェノベーゼ' },
    { level2: 'ミートソース' },
    { level2: '和風パスタ' },
    { level2: 'オイルパスタ' }
  ] },
  { level1: '麺類', level1_children: [
    { level2: 'そば' },
    { level2: 'そうめん' },
    { level2: '坦々麺' },
    { level2: 'うどん' },
    { level2: 'ラーメン' }
  ] },
  { level1: 'お菓子', level1_children: [
    { level2: 'ケーキ' },
    { level2: 'パンケーキ' },
    { level2: 'クッキー' },
    { level2: 'マフィン' },
    { level2: '和菓子' }
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


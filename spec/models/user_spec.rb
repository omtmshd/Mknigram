require 'rails_helper'

RSpec.describe User, type: :model do

  let(:user) { create(:user) }

  it "ファクトリーが有効であること" do
    expect(user).to be_valid
  end

  it "名前、メール、パスワードがある場合、有効であること" do
    user = User.new(
      name: "taro",
      email: "taro@gmail.com",
      password: "password"
    )
    expect(user).to be_valid
  end

  describe "存在性" do

    it "名前がない場合、無効であること" do
      user.name = " "
      user.valid?
      expect(user). to_not be_valid
    end

    it "メールアドレスがない場合、無効であること" do
      user.email = " "
      user.valid?
      expect(user). to_not be_valid
    end

    it "パスワードがない場合、無効であること" do
      user.password = user.password_confirmation = " " * 8
      user.valid?
      expect(user). to_not be_valid
    end
  end

  describe "文字数" do

    it "名前が15字以内である場合、有効であること" do
      user.name = "a" * 15
      user.valid?
      expect(user). to be_valid
    end

    it "名前が16字以上である場合、無効であること" do
      user.name = "a" * 16
      user.valid?
      expect(user). to_not be_valid
    end

    it "プロフィールが150字以内である場合、有効であること" do
      user.profile = "a" * 150
      user.valid?
      expect(user). to be_valid
    end

    it "プロフィールが151字以上である場合、無効であること" do
      user.profile = "a" * 151
      user.valid?
      expect(user). to_not be_valid
    end

    it "メールアドレスが255文字以内の場合、有効であること" do
      user.email = "a" * 245 + "@gmail.com"
      expect(user).to be_valid
    end

    it "メールアドレスが255文字を越える場合、無効であること" do
      user.email = "a" * 246 + "@gmail.com"
      user.valid?
      expect(user).to_not be_valid
    end
    it "パスワードが6字以上である場合、有効であること" do
      user.password = user.password_confirmation = "a" * 6
      user.valid?
      expect(user). to be_valid
    end
    it "パスワードが5字以内である場合、無効であること" do
      user.password = user.password_confirmation = "a" * 5
      user.valid?
      expect(user). to_not be_valid
    end
  end

  describe "一意性" do

    it "メールアドレスが重複した場合、無効であること" do
      user1 = create(:user, name: "taro", email: "taro@gmail.com")
      user2 = build(:user, name: "ziro", email: user1.email)
      expect(user2).to_not be_valid
    end
    it "メールアドレスは大文字小文字を区別せず扱うこと" do
      user.email = "test@gmail.com"
      duplicate_user = build(:user, email: "TEST@GMAIL.COM")
      duplicate_user.valid?
      expect(duplicate_user). to_not be_valid
    end
  end

  describe "パスワード" do

    it "パスワードが確認用と異なる場合、無効であること" do
      user.password = "password"
      user.password_confirmation = "passwo"
      user.valid?
      expect(user). to_not be_valid
    end
    it "パスワードが暗号化されていること" do
      user = create(:user)
      expect(user.encrypted_password).to_not eq "password"
    end
  end

  describe "関連づけされたモデル" do
    it "ユーザーが削除された場合、関連する投稿も削除されること" do
    end
  end

end

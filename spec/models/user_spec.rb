require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  it 'ファクトリーが有効であること' do
    expect(user).to be_valid
  end

  it '名前、メール、パスワードがある場合、有効であること' do
    user = User.new(
      name: 'taro',
      email: 'taro@gmail.com',
      password: 'password'
    )
    expect(user).to be_valid
  end

  describe '存在性' do
    it '名前がない場合、無効であること' do
      user.name = ' '
      user.valid?
      expect(user). to_not be_valid
    end

    it 'メールアドレスがない場合、無効であること' do
      user.email = ' '
      user.valid?
      expect(user). to_not be_valid
    end

    it 'パスワードがない場合、無効であること' do
      user.password = user.password_confirmation = ' ' * 8
      user.valid?
      expect(user). to_not be_valid
    end
  end

  describe '文字数' do
    it '名前が15字以内である場合、有効であること' do
      user.name = 'a' * 15
      user.valid?
      expect(user). to be_valid
    end

    it '名前が16字以上である場合、無効であること' do
      user.name = 'a' * 16
      user.valid?
      expect(user). to_not be_valid
    end

    it 'プロフィールが150字以内である場合、有効であること' do
      user.profile = 'a' * 150
      user.valid?
      expect(user). to be_valid
    end

    it 'プロフィールが151字以上である場合、無効であること' do
      user.profile = 'a' * 151
      user.valid?
      expect(user). to_not be_valid
    end

    it 'メールアドレスが255文字以内の場合、有効であること' do
      user.email = 'a' * 245 + '@gmail.com'
      expect(user).to be_valid
    end

    it 'メールアドレスが255文字を越える場合、無効であること' do
      user.email = 'a' * 246 + '@gmail.com'
      user.valid?
      expect(user).to_not be_valid
    end
    it 'パスワードが6字以上である場合、有効であること' do
      user.password = user.password_confirmation = 'a' * 6
      user.valid?
      expect(user). to be_valid
    end
    it 'パスワードが5字以内である場合、無効であること' do
      user.password = user.password_confirmation = 'a' * 5
      user.valid?
      expect(user). to_not be_valid
    end
  end

  describe '一意性' do
    it 'メールアドレスが重複した場合、無効であること' do
      user1 = create(:user, name: 'taro', email: 'taro@gmail.com')
      user2 = build(:user, name: 'ziro', email: user1.email)
      expect(user2).to_not be_valid
    end
  end

  describe 'パスワード' do
    it 'パスワードが確認用と異なる場合、無効であること' do
      user.password = 'password'
      user.password_confirmation = 'passwo'
      user.valid?
      expect(user). to_not be_valid
    end
    it 'パスワードが暗号化されていること' do
      user = create(:user)
      expect(user.encrypted_password).to_not eq 'password'
    end
  end

  describe '関連づけされたモデル' do
    it 'ユーザーを削除した場合、関連する投稿も削除されること' do
      user = create(:user, :with_posts, posts_count: 1)
      expect { user.destroy }.to change { Post.count }.by(-1)
    end
    it 'ユーザーを削除した場合、関連するいいねも削除されること' do
      user = create(:sub_user, :with_likes, likes_count: 1)
      expect { user.destroy }.to change { Like.count }.by(-1)
    end
    it 'ユーザーを削除した場合、関連するlist_foldersも削除されること' do
      user = create(:user, :with_list_folders, list_folders_count: 1)
      expect { user.destroy }.to change { ListFolder.count }.by(-1)
    end
    it 'ユーザーを削除した場合、フォロー関係も削除されること' do
      alice = create(:user)
      bob = create(:user, email: 'bob@example.com')
      alice.follow(bob)
      expect(bob.followed?(alice)).to eq true
      expect { alice.destroy }.to change { bob.followers.count }.by(-1)
    end
    it 'ユーザーを削除した場合、フォロワー関係も削除されること' do
      alice = create(:user)
      bob = create(:user, email: 'bob@example.com')
      bob.follow(alice)
      expect(bob.following?(alice)).to eq true
      expect { alice.destroy }.to change { bob.following.count }.by(-1)
    end
  end

  it 'ユーザーをフォロー/解除できること' do
    alice = create(:user)
    bob = create(:user, email: 'bob@example.com')
    expect(alice.following?(bob)).to eq false
    alice.follow(bob)
    expect(alice.following?(bob)).to eq true
    alice.unfollow(bob)
    expect(alice.following?(bob)).to eq false
  end
end

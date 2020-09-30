require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:post) { create(:post) }

  it 'ファクトリーが有効であること' do
    expect(post).to be_valid
  end

  describe '存在性' do
    it 'user_idがない場合、無効であること' do
      post.user = nil
      expect(post).to_not be_valid
    end

    it 'タイトルがない場合、無効であること' do
      post.title = nil
      expect(post).to_not be_valid
    end

    it '画像がない場合、無効であること' do
      post.post_image = nil
      expect(post).to_not be_valid
    end

    it 'レシピがない場合、有効であること' do
      post.body = nil
      expect(post).to be_valid
    end
  end

  describe '文字数' do
    it 'タイトルの文字数が20字以内である場合、有効であること' do
      post.title = 'a' * 20
      expect(post).to be_valid
    end

    it 'タイトルの文字数が21字以上である場合、無効であること' do
      post.title = 'a' * 21
      expect(post).to_not be_valid
    end

    it 'レシピの文字数が250以内である場合、有効であること' do
      post.body = 'a' * 250
      expect(post).to be_valid
    end

    it 'レシピの文字数が251以上である場合、無効であること' do
      post.body = 'a' * 251
      expect(post).to_not be_valid
    end
  end

  describe '関連モデル' do
    it '投稿を削除した場合、関連するいいねも削除されること' do
      post = create(:post, :with_post_likes, likes_count: 1)
      expect { post.destroy }.to change { Like.count }.by(-1)
    end

    it '投稿を削除した場合、関連するListも削除されること' do
      post = create(:post, :with_post_lists, lists_count: 1)
      expect { post.destroy }.to change { List.count }.by(-1)
    end
  end
end

require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:like) { create(:like) }

  it 'ファクトリーが有効であること' do
    expect(like).to be_valid
  end

  it 'post_idがない場合、無効であること' do
    like.post = nil
    expect(like).to_not be_valid
  end

  it 'user_idがない場合、無効であること' do
    like.user = nil
    expect(like).to_not be_valid
  end
end

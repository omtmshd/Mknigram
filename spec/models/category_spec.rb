require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:category) { create(:category) }

  it 'ファクトリーが有効であること' do
    expect(category).to be_valid
  end

  it '名前の文字数が20字以内である場合、有効であること' do
    category.name = 'a' * 20
    expect(category).to be_valid
  end

  it '名前の文字数が21字以上である場合、無効であること' do
    category.name = 'a' * 21
    expect(category).to_not be_valid
  end

  it 'タイトルがない場合、無効であること' do
    category.name = nil
    expect(category).to_not be_valid
  end
end

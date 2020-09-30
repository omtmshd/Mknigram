require 'rails_helper'

RSpec.describe List, type: :model do
  let(:list) { create(:list) }

  it 'ファクトリーが有効であること' do
    expect(list).to be_valid
  end

  it 'post_idがない場合、無効であること' do
    list.post = nil
    expect(list).to_not be_valid
  end

  it 'list_folder_idがない場合、無効であること' do
    list.list_folder = nil
    expect(list).to_not be_valid
  end
end

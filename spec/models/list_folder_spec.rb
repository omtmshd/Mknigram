require 'rails_helper'

RSpec.describe ListFolder, type: :model do
  let(:list_folder) { create(:list_folder) }

  it 'ファクトリーが有効であること' do
    expect(list_folder).to be_valid
  end

  it '名前の文字数が25字以内である場合、有効であること' do
    list_folder.name = 'a' * 25
    expect(list_folder).to be_valid
  end

  it '名前の文字数が26字以上である場合、無効であること' do
    list_folder.name = 'a' * 26
    expect(list_folder).to_not be_valid
  end

  it 'user_idがない場合、無効であること' do
    list_folder.user = nil
    expect(list_folder).to_not be_valid
  end

  it '名前がない場合、無効であること' do
    list_folder.name = nil
    expect(list_folder).to_not be_valid
  end

  it 'list_folderを削除した場合、listも削除されること' do
    list_folder = create(:list_folder, :with_lists, lists_count: 1)
    expect { list_folder.destroy }.to change { List.count }.by(-1)
  end
end

require 'rails_helper'

RSpec.describe Tagging, type: :model do
  context 'create' do
    before :each do
      @user = create(:user, email: 'test111@qq.com')
    end
    it 'require record' do
      tag = create :tag
      tagging = build :tagging, tag: tag, record: nil
      tagging.validate
      expect(tagging.errors.details[:record][0][:error]).to eq(:blank)
      expect(tagging.errors[:record][0]).to eq('记录不能为空')
    end
    it 'require tag' do
      record = create :record, user: @user
      tagging = build :tagging, record: record, tag: nil
      tagging.validate
      expect(tagging.errors.details[:tag][0][:error]).to eq(:blank)
      expect(tagging.errors[:tag][0]).to eq('标签不能为空')
    end
    it 'has record and tag' do
      tag = create :tag
      record = create :record, user: @user
      create :tagging, tag: tag, record: record
      expect(tag.records.first.id).to eq(record.id)
      expect(record.tags.first.id).to eq(tag.id)
    end
    it 'has records and tags' do
      tag1 = create :tag, name: 'test1'
      tag2 = create :tag, name: 'test2'
      record1 = create :record, user: @user
      record2 = create :record, user: @user
      create :tagging, tag: tag1, record: record1
      create :tagging, tag: tag1, record: record2
      create :tagging, tag: tag2, record: record1
      create :tagging, tag: tag2, record: record2
      expect(tag1.records.count).to eq 2
      expect(tag2.records.count).to eq 2
      expect(record1.tags.count).to eq 2
      expect(record2.tags.count).to eq 2
    end
  end
end

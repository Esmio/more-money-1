require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "Tags" do
  let(:tag) { Tag.create! name: 'test' }
  let(:id) { tag.id }
  let(:name) {'test'}

  post "/tags" do
    parameter :name, '标签名', type: :string, required: true
    example "创建标签" do
      sign_in
      do_request
      expect(status).to eq 200
    end
  end

  delete "/tags/:id" do
    example "删除标签" do
      sign_in
      do_request
      expect(status).to eq 200
    end
  end

  get "/tags" do
    parameter :page, '页码', type: :integer

    let(:page) { 1 }

    (1..11).to_a.map do |n|
      Tag.create! name: "test#{n}"
    end
    example '获取所有标签' do
      sign_in
      do_request
      expect(status).to eq 200
    end
  end

  get "/tags/:id" do
    example '获取一个标签' do
      sign_in
      do_request
      expect(status).to eq 200
    end
  end

  patch "/tags/:id" do
    example '更新一个标签' do
      sign_in
      do_request name: 'new'
      expect(status).to eq 200
    end
  end
end
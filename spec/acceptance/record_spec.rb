require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "Records" do
  post "/records" do
    parameter :amount , '金额', type: :integer, require: true
    parameter :category, '类型:1 outgoings |2 income', type: :string, require: true
    parameter :notes, '备注', type: :string
    example "创建记账" do
      sign_in
      do_request(amount: 10000, category: 'income', notes: '彩票中奖')
      expect(status).to eq 200
    end
  end

  delete "/records/:id" do
    let(:record){ Record.create! amount: 10000, category: 'income' }
    let(:id){record.id}
    example "删除记录" do
      sign_in
      do_request
      expect(status).to eq 200
    end
  end
end
require 'rails_helper'

RSpec.describe Record, type: :model do
  it 'amount is required' do
    record = Record.create notes: 'xxx', category: 'outgoings'
    p record.errors
    expect(record.errors.details[:amount][0][:error]).to eq(:blank)
  end
  it 'category is required' do
    record = Record.create notes: 'xxx', amount: 10000
    p record.errors
    expect(record.errors.details[:category][0][:error]).to eq(:blank)
  end
end
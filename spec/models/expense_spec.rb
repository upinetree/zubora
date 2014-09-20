require 'spec_helper'

describe Expense do
  context 'validation' do
    let(:expense) { Expense.new }
    it do
      expense.amount = nil
      expect(expense).not_to be_valid
    end
  end

  context 'default values' do
    let(:expense) { build(:expense, accrued_on: nil) }
    it 'accrued_onが空のとき、今日の日付が保存される' do
      expense.save
      expect(expense.accrued_on).to eq(Date.today)
    end
  end
end

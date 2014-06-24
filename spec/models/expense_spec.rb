require 'spec_helper'

describe Expense do
  context 'validation' do
    let(:expense) { Expense.new }
    it do
      expense.amount = nil
      expect(expense).not_to be_valid
    end
  end
end

class AddAccruedOnToExpenses < ActiveRecord::Migration
  def change
    add_column :expenses, :accrued_on, :date
    add_index :expenses, :accrued_on
  end
end

class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.integer :amount, null: false

      t.timestamps
    end
  end
end

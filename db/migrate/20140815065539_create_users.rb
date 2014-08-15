class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email,           null: false
      t.string :password_digest, null: false
      t.string :screen_name,     null: false

      t.timestamps
    end

    add_index :users, :email, unique: true
    add_index :users, :screen_name, unique: true
  end
end

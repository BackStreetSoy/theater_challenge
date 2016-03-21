class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :name
      t.string :email
      t.integer :credit_card_number
      t.datetime :credit_card_expiration

      t.timestamps null: false
    end
  end
end

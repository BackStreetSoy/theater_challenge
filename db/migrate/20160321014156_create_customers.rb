class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :name
      t.string :email
      t.string :credit_card_type
      t.integer :credit_card_number
      t.datetime :card_expiration


      t.timestamps null: false
    end
  end
end

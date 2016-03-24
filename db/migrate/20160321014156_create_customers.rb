class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :name
      t.string :email
      t.integer :credit_card_number
      t.datetime :card_expiration
      # t.datetime :card_expiration_month
      # t.datetime :card_expiration_year

      t.timestamps null: false
    end
  end
end

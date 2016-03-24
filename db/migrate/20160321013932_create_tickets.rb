class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.float :price
      t.integer :showing_id

      t.timestamps null: false
    end
  end
end

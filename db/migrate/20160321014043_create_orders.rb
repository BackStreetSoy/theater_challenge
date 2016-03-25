class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.float   :number_tickets_bought
      t.float   :total_price
      t.integer :movie_id


      t.timestamps null: false
    end
  end
end

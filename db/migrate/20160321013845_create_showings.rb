class CreateShowings < ActiveRecord::Migration
  def change
    create_table :showings do |t|
      t.datetime :time
      t.integer :movie_id
      t.boolean :sold_out?

      t.timestamps null: false
    end
  end
end

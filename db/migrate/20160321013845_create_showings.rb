class CreateShowings < ActiveRecord::Migration
  def change
    create_table :showings do |t|
      t.string :time_string
      t.float :military_time
      t.integer :movie_id
      t.boolean :sold_out?, default: false

      t.timestamps null: false
    end
  end
end

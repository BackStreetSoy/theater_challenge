class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :title
      t.datetime :runtime
      t.boolean :placed?
      t.integer :auditorium_id

      t.timestamps null: false
    end
  end
end

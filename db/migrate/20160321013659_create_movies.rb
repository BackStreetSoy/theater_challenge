class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :title
      t.string :synopsis
      t.float :runtime
      t.string :image
      t.boolean :placed?, default: false
      t.integer :auditorium_id

      t.timestamps null: false
    end
  end
end

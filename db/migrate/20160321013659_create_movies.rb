class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :title
      t.string :synopsis
      t.float :runtime
      t.string :image
      t.string :status
      t.integer :auditorium_id, :null => true

      t.timestamps null: false
    end
  end
end

class CreateAuditoria < ActiveRecord::Migration
  def change
    create_table :auditoria do |t|
      t.integer :seat_count
      t.string  :movie_title
      t.integer :theater_id 
    
      t.timestamps null: false
    end
  end
end

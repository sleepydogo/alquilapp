class CreateTickets < ActiveRecord::Migration[7.0]
  def change
    create_table :tickets do |t|
      t.boolean :activo, default: true  
      t.string :opcion
      t.string :mensaje
      t.timestamps
      t.references :car, null: false, foreign_key: true
	    t.references :user, null: false, foreign_key: true	
    end
  end
end

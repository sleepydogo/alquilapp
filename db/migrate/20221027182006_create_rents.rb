class CreateRents < ActiveRecord::Migration[7.0]
  def change
    create_table :rents do |t|
      t.float :precio, default: 0
      #t.datetime :fecha, default: DateTime.now
	    t.float :combustible_gastado, default: 0
	    t.datetime :tiempo
      #t.datetime :tiempo_original
	    t.boolean :activo, default: true
	    t.references :car, null: false, foreign_key: true
	    t.references :user, null: false, foreign_key: true	
 
      t.timestamps
    end
  end
end

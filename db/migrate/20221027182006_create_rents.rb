class CreateRents < ActiveRecord::Migration[7.0]
  def change
    create_table :rents do |t|
      t.float :precio
      t.datetime :fecha
	  t.float :combustible_gastado, default: 0
	  t.integer :tiempo_minutos, default: 0 
	  t.references :car, null: false, foreign_key: true
	  t.references :user, null: false, foreign_key: true	
 
      t.timestamps
    end
  end
end

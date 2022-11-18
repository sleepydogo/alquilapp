class CreateCars < ActiveRecord::Migration[7.0]
  def change
    create_table :cars do |t|
      t.string :patente
      t.string :modelo, default: ""
	  t.float :tanque, default: 0
	  t.float :combustible, default: 0
	  t.integer :kilometraje, default: 0
	  t.boolean :alquilado, default: false
	  t.boolean :estacionado, default: true
	  t.boolean :de_baja, default: false
    t.float :lat
    t.float :lng 

      t.timestamps
    end
  end
end

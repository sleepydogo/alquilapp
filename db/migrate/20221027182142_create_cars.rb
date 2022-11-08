class CreateCars < ActiveRecord::Migration[7.0]
  def change
    create_table :cars do |t|
      t.string :patente
      t.string :modelo, default: ""
	  t.float :tanque, default: 0
	  t.integer :kilometraje, default: 0
	  t.boolean :alquilado, default: false 

      t.timestamps
    end
  end
end

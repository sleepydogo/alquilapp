class CreateCars < ActiveRecord::Migration[7.0]
  def change
    create_table :cars do |t|
      t.string :patente
      t.string :modelo
	  t.float :combustible, default: 0 

      t.timestamps
    end
  end
end

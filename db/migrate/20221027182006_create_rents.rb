class CreateRents < ActiveRecord::Migration[7.0]
  def change
    create_table :rents do |t|
      t.float :precio
      t.datetime :fecha
	  t.float :combustible_gastado, default: 0

      t.timestamps
    end
  end
end

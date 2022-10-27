class CreateRents < ActiveRecord::Migration[7.0]
  def change
    create_table :rents do |t|
      t.float :precio
      t.datetime :fecha

      t.timestamps
    end
  end
end

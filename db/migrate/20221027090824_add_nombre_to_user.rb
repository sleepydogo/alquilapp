class AddNombreToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :nombre, :string
  end
end

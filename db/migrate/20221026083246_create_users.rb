class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.integer :dni
      t.integer :genero
      t.date :fecha_nacimiento
      t.integer :telefono
      t.string :mail
      t.string :password_digest

      t.timestamps
    end
  end
end

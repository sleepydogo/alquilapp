class CreatePagos < ActiveRecord::Migration[7.0]
  def change
    create_table :pagos do |t|
      t.integer :usuario_id
      t.decimal :precio
      t.boolean :aceptado
      t.text :request
      t.text :response
      t.datetime :fecha

      t.timestamps
    end
  end
end

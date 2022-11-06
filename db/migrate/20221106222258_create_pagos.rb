class CreatePagos < ActiveRecord::Migration[7.0]
  def change
    create_table :pagos do |t|
      t.string :user
      t.decimal :precio
      t.decimal :saldo
      t.boolean :aceptado
      t.text :request
      t.text :response
      t.datetime :fecha

      t.timestamps
    end
  end
end

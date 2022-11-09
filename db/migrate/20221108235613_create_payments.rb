class CreatePayments < ActiveRecord::Migration[7.0]
  def change
    create_table :payments do |t|
      t.decimal :precio
      t.boolean :aceptado
      t.json :request
      t.json :response

      t.timestamps
    end
  end
end

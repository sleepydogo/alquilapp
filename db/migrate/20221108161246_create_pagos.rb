class CreatePagos < ActiveRecord::Migration[7.0]
  def change
    create_table :pagos do |t|
      t.decimal :precio
      t.boolean :aceptado
      t.text :request
      t.text :response
	  t.references :user, null: false, foreign_key: true	

      t.timestamps
    end
  end
end

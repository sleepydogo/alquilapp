class CreatePayments < ActiveRecord::Migration[7.0]
  def change
    create_table :payments do |t|
      t.decimal :precio, default: 0
      t.boolean :aceptado, default: false
      t.integer :id_mp, default: 0 
      t.json :request
      t.json :response
	  t.references :user, null: false, foreign_key: true	

      t.timestamps
    end
  end
end

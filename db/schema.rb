# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_11_28_220843) do
  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "cars", force: :cascade do |t|
    t.string "patente"
    t.string "modelo", default: ""
    t.float "tanque", default: 0.0
    t.float "combustible", default: 0.0
    t.integer "kilometraje", default: 0
    t.boolean "alquilado", default: false
    t.boolean "estacionado", default: true
    t.boolean "de_baja", default: false
    t.float "lat"
    t.float "lng"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "payments", force: :cascade do |t|
    t.decimal "precio", default: "0.0"
    t.boolean "aceptado", default: false
    t.integer "id_mp", default: 0
    t.json "request"
    t.json "response"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_payments_on_user_id"
  end

  create_table "rents", force: :cascade do |t|
    t.float "precio", default: 0.0
    t.float "combustible_gastado", default: 0.0
    t.datetime "tiempo"
    t.boolean "activo", default: true
    t.integer "car_id", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["car_id"], name: "index_rents_on_car_id"
    t.index ["user_id"], name: "index_rents_on_user_id"
  end

  create_table "tickets", force: :cascade do |t|
    t.boolean "activo", default: true
    t.string "opcion"
    t.string "mensaje"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "car_id", null: false
    t.integer "user_id", null: false
    t.index ["car_id"], name: "index_tickets_on_car_id"
    t.index ["user_id"], name: "index_tickets_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "name"
    t.string "dni"
    t.integer "genero"
    t.date "birthdate"
    t.integer "telephone"
    t.integer "rango"
    t.float "saldo", default: 500.0
    t.boolean "alquilando", default: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "payments", "users"
  add_foreign_key "rents", "cars"
  add_foreign_key "rents", "users"
  add_foreign_key "tickets", "cars"
  add_foreign_key "tickets", "users"
end

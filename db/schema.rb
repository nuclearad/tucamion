# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20151005224336) do

  create_table "addpicturetobanners", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "banners", force: true do |t|
    t.string   "name"
    t.integer  "type_truck_id"
    t.date     "limite"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
  end

  create_table "boxes_trucks", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "brand_extras", force: true do |t|
    t.string   "name"
    t.string   "link_rewrite"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "brand_trucks", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "link_rewrite"
  end

  create_table "cities", force: true do |t|
    t.string   "name"
    t.integer  "state_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "link_rewrite"
  end

  create_table "colors_trucks", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contacts", force: true do |t|
    t.string   "firstName"
    t.string   "lastName"
    t.string   "email"
    t.string   "phone"
    t.integer  "event"
    t.string   "lang"
    t.string   "subject"
    t.text     "comments"
    t.integer  "place_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contracts_trucks", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "customers", force: true do |t|
    t.string   "name"
    t.string   "cedula"
    t.string   "telefono"
    t.string   "email"
    t.string   "clave"
    t.integer  "typeuser"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "estado",       default: 1
    t.string   "token_active", default: ""
    t.string   "token_pass",   default: ""
  end

  create_table "extras", force: true do |t|
    t.string   "name"
    t.string   "address"
    t.integer  "state_id"
    t.integer  "city_id"
    t.string   "phone"
    t.string   "horario"
    t.text     "description"
    t.string   "link_rewrite"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "picture1_file_name"
    t.string   "picture1_content_type"
    t.integer  "picture1_file_size"
    t.datetime "picture1_updated_at"
    t.string   "picture2_file_name"
    t.string   "picture2_content_type"
    t.integer  "picture2_file_size"
    t.datetime "picture2_updated_at"
    t.string   "picture3_file_name"
    t.string   "picture3_content_type"
    t.integer  "picture3_file_size"
    t.datetime "picture3_updated_at"
    t.string   "picture4_file_name"
    t.string   "picture4_content_type"
    t.integer  "picture4_file_size"
    t.datetime "picture4_updated_at"
    t.string   "picture5_file_name"
    t.string   "picture5_content_type"
    t.integer  "picture5_file_size"
    t.datetime "picture5_updated_at"
    t.integer  "active",                            default: 1
    t.integer  "customer_id"
    t.integer  "user_id",                           default: 0
    t.string   "email"
    t.string   "nit",                   limit: 15,  default: "S/N", null: false
    t.string   "url_map",               limit: 500, default: ""
  end

  create_table "extras_brands_extras", force: true do |t|
    t.integer  "extra_id",       null: false
    t.integer  "brand_extra_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "extras_brands_extras", ["brand_extra_id"], name: "index_extras_brands_extras_on_brand_extra_id", using: :btree
  add_index "extras_brands_extras", ["extra_id"], name: "index_extras_brands_extras_on_extra_id", using: :btree

  create_table "houses", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
  end

  create_table "images", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "marca_carroceria", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "marca_equipo_humedos", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "marca_volcos", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages", force: true do |t|
    t.string   "nombre"
    t.string   "telefono"
    t.text     "mensaje"
    t.integer  "tipo"
    t.integer  "item"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id",     default: 0
    t.integer  "customer_id", default: 0
    t.integer  "status",      default: 1
  end

  create_table "motors_trucks", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "offercustomers", force: true do |t|
    t.integer  "customer_id"
    t.integer  "offer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "offers", force: true do |t|
    t.string   "nombre"
    t.text     "descripcion"
    t.string   "precio1"
    t.string   "precio2"
    t.integer  "trucks",      default: 0
    t.integer  "service",     default: 0
    t.integer  "extra",       default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "typeoffer",   default: 0
  end

  create_table "pictures", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "place_id"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
  end

  create_table "quantities", force: true do |t|
    t.integer  "customer_id",                  null: false
    t.integer  "total_trucks",     default: 0
    t.integer  "total_extras",     default: 0
    t.integer  "total_services",   default: 0
    t.integer  "current_trucks",   default: 0
    t.integer  "current_extras",   default: 0
    t.integer  "current_services", default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "quantities", ["customer_id"], name: "index_quantities_on_customer_id", using: :btree

  create_table "referencias", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "type_truck_id"
  end

  create_table "registers", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "firstName"
    t.string   "lastName"
    t.string   "emailAddress"
    t.string   "customCheckbox"
    t.integer  "place_id"
  end

  create_table "scraps_trucks", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sections", force: true do |t|
    t.string   "title"
    t.string   "name_es"
    t.string   "name_pt"
    t.text     "content_es"
    t.text     "content_pt"
    t.integer  "category"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.string   "meta_title_es"
    t.string   "meta_description_es"
    t.string   "meta_keywords_es"
    t.string   "meta_title_pt"
    t.string   "meta_description_pt"
    t.string   "meta_keywords_pt"
  end

  create_table "services", force: true do |t|
    t.string   "name"
    t.string   "link_rewrite"
    t.integer  "state_id"
    t.integer  "city_id"
    t.string   "horario"
    t.string   "address"
    t.integer  "active",                            default: 1
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "phone"
    t.string   "picture1_file_name"
    t.string   "picture1_content_type"
    t.integer  "picture1_file_size"
    t.datetime "picture1_updated_at"
    t.string   "picture2_file_name"
    t.string   "picture2_content_type"
    t.integer  "picture2_file_size"
    t.datetime "picture2_updated_at"
    t.string   "picture3_file_name"
    t.string   "picture3_content_type"
    t.integer  "picture3_file_size"
    t.datetime "picture3_updated_at"
    t.string   "picture4_file_name"
    t.string   "picture4_content_type"
    t.integer  "picture4_file_size"
    t.datetime "picture4_updated_at"
    t.string   "picture5_file_name"
    t.string   "picture5_content_type"
    t.integer  "picture5_file_size"
    t.datetime "picture5_updated_at"
    t.integer  "customer_id"
    t.integer  "user_id",                           default: 0
    t.string   "email"
    t.string   "nit",                   limit: 15,  default: "S/N", null: false
    t.string   "url_map",               limit: 500, default: ""
  end

  create_table "services_type_services", force: true do |t|
    t.integer  "service_id",      null: false
    t.integer  "type_service_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "services_type_services", ["service_id"], name: "index_services_type_services_on_service_id", using: :btree
  add_index "services_type_services", ["type_service_id"], name: "index_services_type_services_on_type_service_id", using: :btree

  create_table "spaces_trucks", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "states", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "link_rewrite"
  end

  create_table "sub_trucks", force: true do |t|
    t.string   "name"
    t.integer  "type_truck_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tipo_carroceria", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "transmissions_trucks", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "trucks", force: true do |t|
    t.string   "nombre"
    t.string   "modelo"
    t.string   "ubicacion"
    t.string   "kilometraje"
    t.integer  "estado"
    t.string   "placa"
    t.string   "ubicacionplaca"
    t.string   "color"
    t.string   "tipocombustible"
    t.string   "marcamotor"
    t.string   "marcacaja"
    t.string   "marcatransmision"
    t.boolean  "quintarueda"
    t.string   "tipocupo"
    t.string   "empresaafiliada"
    t.string   "marcacarpa"
    t.string   "capacidadcarga"
    t.string   "capacidadpasajeros"
    t.string   "cilindrajecc"
    t.string   "numeroejes"
    t.boolean  "trailer"
    t.boolean  "negociable"
    t.string   "estadollantas"
    t.boolean  "vigia"
    t.integer  "tipodecaja"
    t.boolean  "motorreparado"
    t.boolean  "cajareparada"
    t.boolean  "transmisionreparada"
    t.boolean  "frenosabs"
    t.boolean  "cupo"
    t.boolean  "sillareclinable"
    t.boolean  "bano"
    t.boolean  "descansapies"
    t.boolean  "tv"
    t.boolean  "pantallaindividual"
    t.boolean  "wifi"
    t.boolean  "audio"
    t.boolean  "unicodueno"
    t.integer  "brand_truck_id"
    t.integer  "type_truck_id"
    t.text     "descripcion"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "state_id"
    t.integer  "city_id"
    t.float    "price",                  limit: 24
    t.string   "link_rewrite"
    t.string   "picture1_file_name"
    t.string   "picture1_content_type"
    t.integer  "picture1_file_size"
    t.datetime "picture1_updated_at"
    t.string   "picture2_file_name"
    t.string   "picture2_content_type"
    t.integer  "picture2_file_size"
    t.datetime "picture2_updated_at"
    t.string   "picture3_file_name"
    t.string   "picture3_content_type"
    t.integer  "picture3_file_size"
    t.datetime "picture3_updated_at"
    t.string   "picture4_file_name"
    t.string   "picture4_content_type"
    t.integer  "picture4_file_size"
    t.datetime "picture4_updated_at"
    t.string   "picture5_file_name"
    t.string   "picture5_content_type"
    t.integer  "picture5_file_size"
    t.datetime "picture5_updated_at"
    t.text     "descripccion"
    t.integer  "active",                            default: 1
    t.integer  "placa_city_id"
    t.integer  "placa_state_id"
    t.integer  "wheels_truck_id"
    t.integer  "colors_truck_id"
    t.integer  "spaces_truck_id"
    t.integer  "transmissions_truck_id"
    t.integer  "scraps_truck_id"
    t.integer  "contracts_truck_id"
    t.integer  "boxes_truck_id"
    t.integer  "motors_truck_id"
    t.integer  "customer_id"
    t.integer  "sub_truck_id"
    t.string   "pesobruto"
    t.integer  "referencia_id"
    t.string   "marcacapa"
    t.string   "tipotrailer"
    t.string   "marcatrailer"
    t.string   "modelotrailer"
    t.string   "numeroejestrailer"
    t.string   "sevendecontrailer"
    t.string   "direccion"
    t.integer  "marca_equipo_humedo_id"
    t.integer  "tipo_carroceria_id"
    t.integer  "marca_carroceria_id"
    t.integer  "marca_volco_id"
    t.string   "capacidadmetrica"
    t.string   "cuantosmetroscubicos"
    t.string   "autocarpado"
    t.integer  "user_id",                           default: 0
    t.integer  "ejesretractiles",                   default: 0
    t.string   "phone"
    t.string   "email"
    t.boolean  "aireAcondicionado",                 default: false
  end

  create_table "type_extras", force: true do |t|
    t.string   "name"
    t.string   "link_rewrite"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "type_services", force: true do |t|
    t.string   "name"
    t.string   "link_rewrite"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "type_trucks", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "link_rewrite"
  end

  create_table "types_truck_extras", force: true do |t|
    t.integer  "extra_id",      null: false
    t.integer  "type_truck_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "types_truck_extras", ["extra_id"], name: "index_types_truck_extras_on_extra_id", using: :btree
  add_index "types_truck_extras", ["type_truck_id"], name: "index_types_truck_extras_on_type_truck_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                             default: "", null: false
    t.string   "encrypted_password",                default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                     default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name",             limit: 20,              null: false
    t.string   "last_name",              limit: 20,              null: false
    t.integer  "status",                            default: 1
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "wheels_trucks", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end

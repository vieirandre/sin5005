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

ActiveRecord::Schema.define(version: 2019_11_07_063433) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "dados_fundos", force: :cascade do |t|
    t.string "codigoAtivo"
    t.string "rendimento"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "dataBase"
    t.string "diaPagamento"
  end

  create_table "fundos", force: :cascade do |t|
    t.string "ticker"
    t.string "preco"
    t.string "nome"
    t.string "cnpj"
    t.string "segmento"
    t.string "tx_adm"
    t.string "data_const"
    t.string "num_cotas_emitidas"
    t.string "patrimonio_inicial"
    t.string "valor_inicial_cota"
    t.string "prazo"
    t.string "tipo_gestao"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tiles", force: :cascade do |t|
    t.bigint "usuarios_id"
    t.bigint "fundos_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["fundos_id"], name: "index_tiles_on_fundos_id"
    t.index ["usuarios_id"], name: "index_tiles_on_usuarios_id"
  end

  create_table "usuarios", force: :cascade do |t|
    t.string "login"
    t.string "senha"
    t.string "nome"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "tiles", "fundos", column: "fundos_id"
  add_foreign_key "tiles", "usuarios", column: "usuarios_id"
end

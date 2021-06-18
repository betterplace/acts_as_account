ActiveRecord::Schema.define(version: 1) do
  if ENV['DROP_FK']
    execute "ALTER TABLE acts_as_account_postings DROP FOREIGN KEY account_id"
    execute "ALTER TABLE acts_as_account_postings DROP FOREIGN KEY other_account_id"
    execute "ALTER TABLE acts_as_account_postings DROP FOREIGN KEY journal_id"
  end

  create_table "acts_as_account_accounts", force: true do |t|
    t.belongs_to  "holder", null: false
    t.string      "holder_type", null: false
    t.string      "name", null: false

    t.integer     "balance", default: 0
    t.integer     "postings_count", default: 0
    t.datetime    "last_valuta"

    t.datetime    "created_at"
    t.datetime    "updated_at"
  end
  add_index "acts_as_account_accounts", ["holder_id", "holder_type", "name"], name: 'account_unique', unique: true

  create_table "acts_as_account_journals", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "acts_as_account_postings", force: true do |t|
    t.belongs_to "account", null: false, index: true
    t.belongs_to "other_account", null: false
    t.belongs_to "journal", null: false, index: true
    t.integer    "amount", null: false

    t.belongs_to "reference"
    t.string     "reference_type"

    t.datetime   "valuta"

    t.datetime   "created_at"
    t.datetime   "updated_at"
  end
  add_index "acts_as_account_postings", ["reference_type", "reference_id"], name: "reference"
  add_index "acts_as_account_postings", ["valuta", "id"], name: "sort_key"

  create_table "acts_as_account_global_accounts", force: true do |t|
    t.string   "name", null: false
  end

  create_table "users", force: true do |t|
    t.string   "name", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "abstract_users", force: true do |t|
    t.string   "name", null: false
    t.string   "type", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cheques", force: true do |t|
    t.string "number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end
end

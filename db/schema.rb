ActiveRecord::Schema.define(:version => 1) do
  create_table "acts_as_account_accounts", :force => true do |t|
    t.integer  "holder_id", :null => false
    t.string   "holder_type", :null => false
    t.string   "name", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end
  add_index "acts_as_account_accounts", ["holder_id", "holder_type", "name"], :name => 'account_unique', :unique => true

  create_table "acts_as_account_journals", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "acts_as_account_postings", :force => true do |t|
    t.integer "account_id", :null => false
    t.integer "journal_id", :null => false
    t.integer "amount", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end
  add_index "acts_as_account_postings", "account_id"
  add_index "acts_as_account_postings", "journal_id"

  create_table "acts_as_account_global_accounts", :force => true do |t|
    t.string   "name", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "name", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end
end

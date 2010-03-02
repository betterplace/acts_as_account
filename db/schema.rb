ActiveRecord::Schema.define(:version => 1) do
  create_table "acts_as_account_accounts", :force => true do |t|
    t.integer  "holder_id", :null => false
    t.string   "holder_type", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "acts_as_account_journals", :force => true do |t|
    t.integer "account_id", :null => false
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

  create_table "users", :force => true do |t|
    t.string   "name", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end
end

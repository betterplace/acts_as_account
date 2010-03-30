ActiveRecord::Schema.define(:version => 1) do
  if ENV['DROP_FK']
    execute "ALTER TABLE acts_as_account_postings DROP FOREIGN KEY account_id"
    execute "ALTER TABLE acts_as_account_postings DROP FOREIGN KEY other_account_id"
    execute "ALTER TABLE acts_as_account_postings DROP FOREIGN KEY journal_id"
  end
  
  create_table "acts_as_account_accounts", :force => true do |t|
    t.integer  "holder_id", :null => false
    t.string   "holder_type", :null => false
    t.string   "name", :null => false
    
    t.integer  "amount", :default => 0
    
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
    t.integer "other_account_id", :null => false
    t.integer "journal_id", :null => false
    t.integer "amount", :null => false
    
    t.integer "reference_id"
    t.string "reference_type"

    t.datetime "valuta"

    t.datetime "created_at"
    t.datetime "updated_at"
  end
  add_index "acts_as_account_postings", "account_id"
  add_index "acts_as_account_postings", "journal_id"
  add_index "acts_as_account_postings", ["reference_type", "reference_id"], :name => "reference"
  add_index "acts_as_account_postings", ["valuta", "id"], :name => "sort_key"
  
  execute "ALTER TABLE acts_as_account_postings ADD CONSTRAINT account_id FOREIGN KEY (account_id) REFERENCES acts_as_account_accounts (id)"
  execute "ALTER TABLE acts_as_account_postings ADD CONSTRAINT other_account_id FOREIGN KEY (other_account_id) REFERENCES acts_as_account_accounts (id)"
  execute "ALTER TABLE acts_as_account_postings ADD CONSTRAINT journal_id FOREIGN KEY (journal_id) REFERENCES acts_as_account_journals (id)"

  create_table "acts_as_account_global_accounts", :force => true do |t|
    t.string   "name", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "name", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end
  
  create_table "cheques", :force => true do |t|
    t.string "number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end
end

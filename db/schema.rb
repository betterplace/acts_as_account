ActiveRecord::Schema.define(:version => 1) do
  # execute "ALTER TABLE acts_as_account_postings DROP FOREIGN KEY account_id"
  # execute "ALTER TABLE acts_as_account_postings DROP FOREIGN KEY other_account_id"
  # execute "ALTER TABLE acts_as_account_postings DROP FOREIGN KEY journal_id"

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
    t.integer "other_account_id", :null => false
    t.integer "journal_id", :null => false
    t.integer "amount", :null => false
    
    t.integer "reference_id"
    t.string "reference_type"

    t.datetime "created_at"
    t.datetime "updated_at"
  end
  # FKs
  add_index "acts_as_account_postings", "account_id"
  add_index "acts_as_account_postings", "journal_id"
  add_index "acts_as_account_postings", ["reference_type", "reference_id"], :name => "reference"
  add_index "acts_as_account_postings", ["created_at", "id"], :name => "sort_key"
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

create_table "bank_statements", :force => true do |t|
  # MT940::Job
  t.string "job_reference"

  # MT940::Account
  t.string "account_number"
  t.string "account_bank_code"
  
  # MT940::Statement
  t.integer "statement_number"
  t.integer "statement_sheet"
  
  # MT940::AccountBalance
  t.string "account_balance_sign"
  t.string "account_balance_currency"
  t.string "account_balance_amount"
  t.date "account_balance_date"

  # MT940::ClosingBalance
  t.string "closing_balance_sign"
  t.string "closing_balance_currency"
  t.string "closing_balance_amount"
  t.date "closing_balance_date"

  t.datetime "created_at"
  t.datetime "updated_at"
end
add_index "bank_statements", ["account_number", "account_bank_code", "statement_number", "statement_sheet"], :name => 'bank_statements', :unique => true

create_table "bank_statement_line", :force => true do |t|
  t.integer "bank_statement_id"

  # MT940::StatementLine
  t.date "date"
  t.date "entry_date"
  t.string "funds_code"
  t.string "amount"
  t.string "swift_code"
  t.string "reference"
  t.string "transaction_description"

  # MT940::StatementLineInformation
  t.string "transaction_description"
  t.string "prima_nota"
  t.string "details"
  t.string "bank_code"
  t.string "account_number"
  t.string "account_holder"
  t.string "text_key_extension"
  
  t.datetime "created_at"
  t.datetime "updated_at"
end

create_table "bank_statement_line", :force => true do |t|
  # MT940::Account
  t.string "account_number"
  t.string "bank_code"
  
  # MT940::Statement
  t.integer "statement_number"
  t.integer "statement_sheet"

  t.integer "statement_sheet_position"
  
  # MT940::StatementLine
  # :date, :entry_date, :funds_code, :amount, :swift_code, :reference, :transaction_description
  t.date "date"
  t.date "entry_date"
  t.string "amount"
  t.string "transaction_description"

  # MT940::StatementLineInformation
  #  :code, :transaction_description, :prima_nota, :details, :bank_code, :account_number, 
  #  :account_holder, :text_key_extension
  t.string "code"
  t.string "transaction_description"
  t.string "prima_nota"
  t.string "details"
  t.string "bank_code"
  t.string "account_number"
  t.string "account_holder"
  t.string "text_key_extension"



  
  ...
end



add_index "bank_statements", ["account_number", "account_bank_code", "statement_number", "statement_sheet", "statement_sheet_position"], :name => 'bank_statements', :unique => true


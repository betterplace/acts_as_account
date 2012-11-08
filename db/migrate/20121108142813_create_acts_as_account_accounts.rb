class CreateActsAsAccountAccounts < ActiveRecord::Migration
  def change
    create_table "acts_as_account_accounts", :force => true do |t|
      t.integer  "holder_id", :null => false
      t.string   "holder_type", :null => false
      t.string   "name", :null => false

      t.integer  "balance", :default => 0
      t.integer  "postings_count", :default => 0
      t.datetime  "last_value"

      t.timestamps
    end
    add_index "acts_as_account_accounts", ["holder_id", "holder_type", "name"], :name => 'account_unique', :unique => true

  end
end

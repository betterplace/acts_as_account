class CreateActsAsAccountPostings < ActiveRecord::Migration
  def change
    create_table "acts_as_account_postings", :force => true do |t|
      t.integer "account_id", :null => false
      t.integer "other_account_id", :null => false
      t.integer "journal_id", :null => false
      t.integer "amount", :null => false

      t.integer "reference_id"
      t.string "reference_type"

      t.datetime "value"

      t.timestamps
    end
    add_index "acts_as_account_postings", "account_id"
    add_index "acts_as_account_postings", "journal_id"
    add_index "acts_as_account_postings", ["reference_type", "reference_id"], :name => "reference"
    add_index "acts_as_account_postings", ["value", "id"], :name => "sort_key"
  end
end

class CreateActsAsAccountGlobalAccounts < ActiveRecord::Migration
  def change
    create_table "acts_as_account_global_accounts", :force => true do |t|
      t.string   "name", :null => false
      t.timestamps
    end
  end
end

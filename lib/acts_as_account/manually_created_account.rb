module ActsAsAccount
  class ManuallyCreatedAccount < ActiveRecord::Base
    set_table_name :acts_as_account_manually_created_accounts
    
    has_account
    
    validates_length_of :name, :minimum => 1
  end
end
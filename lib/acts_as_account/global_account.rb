module ActsAsAccount
  class GlobalAccount < ActiveRecord::Base
    set_table_name :acts_as_account_global_accounts
    
    has_account
  end
end
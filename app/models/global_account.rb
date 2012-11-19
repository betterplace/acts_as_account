class GlobalAccount < ActiveRecord::Base
  self.table_name = :acts_as_account_global_accounts

  has_account
end
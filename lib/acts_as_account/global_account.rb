module ActsAsAccount
  # A named account that is "global" (not tied to any specific entity
  # in your database otherwise).
  #
  # This is useful for accounts that you don't want to model anything
  # for via an ActiveRecord model (like "Cash").
  class GlobalAccount < ActiveRecord::Base
    self.table_name = :acts_as_account_global_accounts

    has_account
  end
end

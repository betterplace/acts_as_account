class User < ActiveRecord::Base
  has_account
  has_account(:not_default)
end

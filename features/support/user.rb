class User < ActsAsAccount::Base
  has_one :account, :class_name => "ActsAsAccount::Account", :as => :holder
end
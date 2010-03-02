class User < ActsAsBank::Base
  has_one :account, :class_name => "ActsAsBank::Account", :as => :holder
end
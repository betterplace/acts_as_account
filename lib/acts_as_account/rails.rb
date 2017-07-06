ActiveRecord::Base.class_eval do
  include ActsAsAccount::ActiveRecordExtension
end

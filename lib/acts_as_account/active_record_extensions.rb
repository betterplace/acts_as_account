module ActsAsAccount
  module ActiveRecordExtension
    def self.included(base) # :nodoc:
      base.extend ClassMethods
      base.class_eval do
        def account(name = :default)
          __send__("#{name}_account") || __send__("create_#{name}_account", :name => name.to_s) 
        end
        
        begin
          establish_connection("#{RAILS_ENV}_acts_as_account") if defined? RAILS_ENV
        rescue ActiveRecord::AdapterNotSpecified
          # If you want an isolated connection specify connection in database.yml
        end
      end
    end
  
    module ClassMethods
      
      def has_account(name = :default)
        has_one "#{name}_account", :conditions => "name = '#{name}'", :class_name => "ActsAsAccount::Account", :as => :holder
        unless instance_methods.include?('accounts')
          has_many :accounts, :class_name => "ActsAsAccount::Account", :as => :holder
        end
      end
      
      def has_global_account(name)
        class_eval <<-EOS
          def account
            ActsAsAccount::Account.for(:#{name})
          end
        EOS
      end
    end
  end
end
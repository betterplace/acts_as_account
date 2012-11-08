require 'active_support/concern'

module ActsAsAccount
  module ActiveRecordExtension
    extend ActiveSupport::Concern

    included do
      def account(name = :default)
        __send__("#{name}_account") || __send__("create_#{name}_account", :name => name.to_s)
      end
    end

    module ClassMethods
      def has_account(name = :default)
        has_one "#{name}_account", :conditions => "name = '#{name}'", :class_name => "Account", :as => :holder
        unless instance_methods.include?('accounts')
          has_many :accounts, :class_name => "Account", :as => :holder
        end
      end

      def is_reference
        has_many :postings, :class_name => "Posting", :as => :reference
        class_eval <<-EOS
          def booked?
            postings.any?
          end
        EOS
      end

      def has_global_account(name)
        class_eval <<-EOS
          def account
            Account.for(:#{name})
          end
        EOS
      end
    end
  end
end
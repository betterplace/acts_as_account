module ActsAsAccount
  module ActionControllerExtensions
    def self.included(base) # :nodoc:
      base.class_eval do
        after_filter :acts_as_account_clear_journal
        
        def acts_as_account_clear_journal
          Journal.clear_current
        end
        private :acts_as_account_clear_journal
      end
    end
  end
end

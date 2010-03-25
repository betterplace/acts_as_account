module ActsAsAccount
  class Journal < Base
    class UncommitedError < StandardError
      attr_accessor :journal
    end 
    
    set_table_name :acts_as_account_journals
    
    has_many :postings
    has_many :accounts, :through => :postings
    
    class << self
      private :new
      private :create
      private :create!

      def current
        Thread.current[:acts_as_account_current] ||= create!
      end
      
      def clear_current
        if journal = Thread.current[:acts_as_account_current]
          begin
            if journal.uncommitted?
              uncommited_error = UncommitedError.new
              uncommited_error.journal = journal
              logger.debug { "ActsAsAccount::UncommitedError: #{uncommited_error.inspect}"} if logger
              raise uncommited_error
            end
          ensure
            Thread.current[:acts_as_account_current] = nil
          end
        end
      end
    end
    
    def uncommitted?
      !!(@uncommitted_transfers && @uncommitted_transfers.any?)
    end
    
    def commit
      return unless uncommitted?

      transaction do
        @uncommitted_transfers.each do |(amount, from_account, to_account, reference)|
          logger.debug { "ActsAsAccount::Journal.commit amount: #{amount} from:#{from_account.id} to:#{to_account.id} reference:#{reference.class.name}(#{reference.id})" } if logger
      
          postings.build(
            :amount => amount * -1, 
            :account => from_account, 
            :other_account => to_account,
            :reference => reference).save_without_validation
          
          postings.build(
            :amount => amount, 
            :account => to_account, 
            :other_account => from_account,
            :reference => reference).save_without_validation
        end
        
        @uncommitted_transfers.clear
      end
    end
    
    def transfer(amount, from_account, to_account, reference = nil)
      @uncommitted_transfers ||= []
      @uncommitted_transfers << [amount, from_account, to_account, reference]
    end
  end
end
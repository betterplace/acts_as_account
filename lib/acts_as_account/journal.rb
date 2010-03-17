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
              raise uncommited_error
            end
          ensure
            Thread.current[:acts_as_account_current] = nil
          end
        end
      end
    end
    
    def uncommitted?
      !!(@uncommitted_postings && @uncommitted_postings.any?)
    end
    
    def commit
      if uncommitted?
        transaction do
          @uncommitted_postings.each(&:save_without_validation)
          @uncommitted_postings.clear
        end
      end
    end
    
    def transfer(amount, from_account, to_account)
      @uncommitted_postings ||= []
      
      @uncommitted_postings << postings.build(
        :amount => amount * -1, 
        :account => from_account, 
        :other_account => to_account)
      @uncommitted_postings << postings.build(
        :amount => amount, 
        :account => to_account,
        :other_account => from_account)
    end
  end
end
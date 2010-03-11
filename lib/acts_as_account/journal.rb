module ActsAsAccount
  class Journal < Base
    class Uncommited < Exception; end 
    
    set_table_name :acts_as_account_journals
    
    has_many :postings
    has_many :accounts, :through => :postings
    
    class << self
      def current
        Thread.current[:acts_as_account_current] ||= create
      end
      
      def clear_current
        if journal = Thread.current[:acts_as_account_current]
          raise Uncommited if journal.uncommitted?
          Thread.current[:acts_as_account_current] = nil
        end
      end
    end
    
    def uncommitted?
      !!(@uncommitted_postings && @uncommitted_postings.any?)
    end
    
    def commit
      transaction do 
        @uncommitted_postings.each(&:save!)
        @uncommitted_postings = []
      end
    end
    
    def transfer(amount, from_account, to_account)
      @uncommitted_postings ||= []
      @uncommitted_postings << postings.build(:amount => amount * -1, :account => from_account)
      @uncommitted_postings << postings.build(:amount => amount, :account => to_account)
    end

  end
end
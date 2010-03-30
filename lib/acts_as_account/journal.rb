module ActsAsAccount
  class Journal < ActiveRecord::Base
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
        Thread.current[:acts_as_account_current] = nil
      end
    end

    def transfer(amount, from_account, to_account, reference = nil, valuta = Time.now)
      transaction do
        logger.debug { "ActsAsAccount::Journal.transfer amount: #{amount} from:#{from_account.id} to:#{to_account.id} reference:#{reference.class.name}(#{reference.id}) valuta:#{valuta}" } if logger
        
        from_account.lock!
        to_account.lock!

        postings.build(
          :amount => amount * -1, 
          :account => from_account, 
          :other_account => to_account,
          :reference => reference,
          :valuta => valuta).save_without_validation
        
        
        postings.build(
          :amount => amount, 
          :account => to_account, 
          :other_account => from_account,
          :reference => reference,
          :valuta => valuta).save_without_validation

        from_account.increment!(:amount, -amount)
        to_account.increment!(:amount, amount)
      end
    end
  end
end
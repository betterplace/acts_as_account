module ActsAsAccount
  class Account < Base
    set_table_name :acts_as_account_accounts
    
    belongs_to :holder, :polymorphic => true
    
    has_many :journals
    has_many :postings
    
    attr_writer :opening_balance

    after_create :create_opening_balance
    
    def balance
      postings.sum(:amount)
    end
    
    def transfer(amount, to_account)
      with_journal do |journal|
        journal.postings.create(:amount => amount * -1)
        journal.postings.create(:amount => amount, :account => to_account)
      end
    end
    
    private
      def create_opening_balance
        return unless @opening_balance
        
        with_journal do |journal|
          journal.postings.create(:amount => @opening_balance)
        end
      end
      
      def with_journal
        returning(journals.create) do |journal|
          yield journal
        end
      end
  end
end
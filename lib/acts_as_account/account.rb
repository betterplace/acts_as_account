module ActsAsAccount
  class Account < Base
    set_table_name :acts_as_account_accounts
    
    attr_writer :opening_balance
    
    belongs_to :holder, :polymorphic => true
    has_many :postings
    has_many :journals, :through => :postings
    
    validates_presence_of :holder
    
    after_create :create_opening_balance
    
    def balance
      postings.sum(:amount)
    end
    
    def transfer(amount, to_account)
      returning(Journal.create) do |journal|
        journal.transfer(amount, self, to_account)
      end
    end
    
    private
      def create_opening_balance
        return unless @opening_balance
        
        Journal.create.postings.create(:amount => @opening_balance, :account => self)
      end
  end
end
module ActsAsBank
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
    
    private
      def create_opening_balance
        return unless @opening_balance
        
        journal = journals.create
        journal.postings.create(:amount => @opening_balance)
      end
  end
end
module ActsAsAccount
  class Account < Base
    set_table_name :acts_as_account_accounts
    
    belongs_to :holder, :polymorphic => true
    has_many :postings
    has_many :journals, :through => :postings
    
    validates_presence_of :holder
    
    def balance
      postings.empty? ? 0 : postings.sum(:amount)
    end
  end
end

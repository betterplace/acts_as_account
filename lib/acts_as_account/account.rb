module ActsAsAccount
  class Account < Base
    set_table_name :acts_as_account_accounts
    
    belongs_to :holder, :polymorphic => true
    has_many :postings
    has_many :journals, :through => :postings
    
    validates_presence_of :holder
    
    class << self
      def for(name)
        GlobalAccount.find_or_create_by_name(name.to_s).account
      end
    end
    
    def balance
      postings.empty? ? 0 : postings.sum(:amount)
    end
  end
end
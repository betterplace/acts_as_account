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

      def create!(attributes = nil)
        find_on_error(attributes) do
          super
        end
      end
      
      def create(attributes = nil)
        find_on_error(attributes) do
          super
        end
      end
      
      def find_on_error(attributes)
        yield
        
      # Trying to create a duplicate key on a unique index raises StatementInvalid
      rescue ActiveRecord::StatementInvalid => e
        record = if attributes[:holder]
          attributes[:holder].account(attributes[:name])
        else
          find(:first, :conditions => [
            "holder_type = ? and holder_id = ? and name = ?",
            attributes[:holder_type], attributes[:holder_id], attributes[:name]
          ])
        end
        record || raise
      end
    end
    
    def balance
      postings.empty? ? 0 : postings.sum(:amount)
    end
  end
end

module ActsAsAccount
  class Journal < Base
    set_table_name :acts_as_account_journals
    
    has_many :postings
    has_many :accounts, :through => :postings
    
    def transfer(amount, from_account, to_account)
      postings.create(:amount => amount * -1, :account => from_account)
      postings.create(:amount => amount, :account => to_account)
    end
  end
end
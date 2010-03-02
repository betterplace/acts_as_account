module ActsAsAccount
  class Journal < Base
    set_table_name :acts_as_account_journals
    
    has_many :postings
    belongs_to :account
  end
end
module ActsAsBank
  class Journal < Base
    set_table_name :acts_as_bank_journals
    
    has_many :postings
    belongs_to :account
  end
end
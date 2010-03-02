module ActsAsBank
  class Posting < Base
    set_table_name :acts_as_account_postings
    
    belongs_to :account
    belongs_to :journal
    
    before_create :set_account
    
    private
      def set_account
        self.account = journal.account 
      end
  end
end
module ActsAsAccount
  class Posting < Base
    set_table_name :acts_as_account_postings
    
    belongs_to :account
    belongs_to :other_account, :class_name => 'Account'
    belongs_to :journal
    
    validates_presence_of :account
    validates_presence_of :other_account
    validates_presence_of :journal
  end
end
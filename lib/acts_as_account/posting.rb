module ActsAsAccount
  class Posting < ActiveRecord::Base
    set_table_name :acts_as_account_postings
    
    belongs_to :account
    belongs_to :other_account, :class_name => 'Account'
    belongs_to :journal
    belongs_to :reference, :polymorphic => true
    
    named_scope :soll,  :conditions => 'amount >= 0'
    named_scope :haben, :conditions => 'amount < 0'
    named_scope :start_date,  lambda{|date| {:conditions => ['DATE(valuta) >= ?', date]}}
    named_scope :end_date,    lambda{|date| {:conditions => ['DATE(valuta) <= ?', date]}}
  end
end
require 'time'

module ActsAsAccount
  class Posting < ActiveRecord::Base
    self.table_name = :acts_as_account_postings

    belongs_to :account,       :class_name => 'ActsAsAccount::Account'
    belongs_to :other_account, :class_name => 'ActsAsAccount::Account'
    belongs_to :journal,       :class_name => 'ActsAsAccount::Journal'
    belongs_to :reference, :polymorphic => true

    scope :soll,       -> { where('amount >= 0') }
    scope :haben,      -> { where('amount < 0') }
    scope :start_date, -> date {
      date = Time.parse(date.to_s).utc.to_fs(:db)
      where(['valuta >= ?', date])
    }
    scope :end_date,   -> date {
      date = Time.parse(date.to_s).utc.to_fs(:db)
      where(['valuta <= ?', date])
    }
  end
end

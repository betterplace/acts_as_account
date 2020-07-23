require 'time'

module ActsAsAccount
  class Posting < ActiveRecord::Base
    self.table_name = :acts_as_account_postings

    belongs_to :account,       :class_name => 'ActsAsAccount::Account'
    belongs_to :other_account, :class_name => 'ActsAsAccount::Account'
    belongs_to :journal,       :class_name => 'ActsAsAccount::Journal'
    belongs_to :reference, :polymorphic => true
    has_one :posting_setting, foreign_key: :acts_as_account_posting_id
    has_one :reason, through: :posting_setting
    has_one :admin, through: :posting_setting
    has_one :order, through: :posting_setting

    scope :for_reference, -> (ref_id) { where(reference_id: ref_id) }
    scope :soll,       -> { where('amount >= 0') }
    scope :haben,      -> { where('amount < 0') }
    scope :start_date, -> date {
      date = Time.parse(date.to_s).utc.to_s(:db)
      where(['valuta >= ?', date])
    }
    scope :end_date,   -> date {
      date = Time.parse(date.to_s).utc.to_s(:db)
      where(['valuta <= ?', date])
    }
  end
end

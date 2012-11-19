class Journal < ActiveRecord::Base
  self.table_name = :acts_as_account_journals

  has_many :postings, :class_name => 'Posting'
  has_many :accounts, :through => :postings

  class << self
    private :new
    private :create
    private :create!

    def current
      Thread.current[:acts_as_account_current] ||= create!
    end

    def clear_current
      Thread.current[:acts_as_account_current] = nil
    end
  end

  def transfers
    [].tap do |transfers|
      postings.in_groups_of(2) { |postings| transfers << Transfer.new(*postings) }
    end
  end

  def transfer(amount, from_account, to_account, reference = nil, value = Time.now)
    transaction do
      if (amount < 0)
        # change order if amount is negative
        amount, from_account, to_account = -amount, to_account, from_account
      end

      logger.debug { "Journal.transfer amount: #{amount} from:#{from_account.id} to:#{to_account.id} reference:#{reference.class.name}(#{reference.id}) value:#{value}" } if logger

      # to avoid possible deadlocks we need to ensure that the locking order is always
      # the same therefore the sort by id.
      [from_account, to_account].sort_by(&:id).map(&:lock!)

      add_posting(-amount,  from_account,   to_account, reference, value)
      add_posting( amount,    to_account, from_account, reference, value)
    end
  end

  private

    def add_posting(amount, account, other_account, reference, value)
      posting = postings.build do |p|
        p.amount = amount
        p.account = account
        p.other_account = other_account
        p.reference = reference
        p.value = value
      end

      account.class.update_counters account.id, :postings_count => 1, :balance => posting.amount

      posting.save(:validate => false)
      account.save(:validate => false)
    end
end

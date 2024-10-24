module ActsAsAccount
  class Journal < ActiveRecord::Base
    self.table_name = :acts_as_account_journals

    has_many :postings, :class_name => 'ActsAsAccount::Posting'
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
        postings.each_slice(2) { |postings| transfers << Transfer.new(*postings) }
      end
    end

    def transfer(amount, from_account, to_account, reference = nil, valuta = Time.now)
      transaction do
        if (amount < 0)
          # change order if amount is negative
          amount, from_account, to_account = -amount, to_account, from_account
        end

        logger.debug { "ActsAsAccount::Journal.transfer amount: #{amount} from:#{from_account.id} to:#{to_account.id} reference:#{reference.class.name}(#{reference.id}) valuta:#{valuta}" } if logger

        # to avoid possible deadlocks we need to ensure that the locking order is always
        # the same therfore the sort by id.
        [from_account, to_account].sort_by(&:id).map(&:lock!) if ActsAsAccount.configuration.persist_attributes_on_account

        add_posting(-amount,  from_account,   to_account, reference, valuta)
        add_posting( amount,    to_account, from_account, reference, valuta)
      end
    end

    private

      def add_posting(amount, account, other_account, reference, valuta)
        posting = postings.build(
          :amount => amount,
          :account => account,
          :other_account => other_account,
          :reference => reference,
          :valuta => valuta)

        update_attributes_on(account, posting)

        posting.save(:validate => false)
      end

      def update_attributes_on(account, posting)
        return unless ActsAsAccount.configuration.persist_attributes_on_account

        account.class.update_counters account.id, postings_count: 1, balance: posting.amount
      end
  end
end

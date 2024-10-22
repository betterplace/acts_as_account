module ActsAsAccount
  class Account < ActiveRecord::Base
    self.table_name = :acts_as_account_accounts

    belongs_to :holder, :polymorphic => true
    has_many :postings, :class_name => 'ActsAsAccount::Posting'
    has_many :journals, :through => :postings

    # TODO: discuss with norman:
    # validates_presence_of will force an ActiveRecord::find on the object
    # but we have to create accounts for deleted holder!
    #
    # validates_presence_of :holder

    class << self
      def recalculate_all_balances
        find_each do |account|
          account.recalculate_balances
        end
      end

      def for(name)
        GlobalAccount.find_or_create_by(name: name).account
      end

      def create!(attributes = nil)
        find_on_error(attributes) do
          super
        end
      end

      def create(attributes = nil)
        find_on_error(attributes) do
          super
        end
      end

      def delete_account(number)
        transaction do
          account = find(number)
          raise ActiveRecord::ActiveRecordError, "Cannot be deleted" unless account.deleteable?

          account.holder.destroy if [ManuallyCreatedAccount, GlobalAccount].include?(account.holder.class)
          account.destroy
        end
      end

      def find_on_error(attributes)
        yield

      # Trying to create a duplicate key on a unique index raises StatementInvalid
      rescue ActiveRecord::StatementInvalid
        record = if attributes[:holder]
          attributes[:holder].account(attributes[:name])
        else
          where(
            :holder_type => attributes[:holder_type],
            :holder_id   => attributes[:holder_id],
            :name        => attributes[:name]
          ).first
        end
        record || raise("Cannot find or create account with attributes #{attributes.inspect}")
      end
    end

    def recalculate_balances
      update_columns(
        balance:        postings.sum(:amount),
        postings_count: postings.count,
        last_valuta:    postings.maximum(:valuta)
      )
    end

    def deleteable?
      postings.empty? && journals.empty?
    end
  end
end

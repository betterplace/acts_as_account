module ActsAsAccount
  class Account < ActiveRecord::Base
    self.table_name = :acts_as_account_accounts

    belongs_to :holder, :polymorphic => true
    has_many :postings, :class_name => 'ActsAsAccount::Posting'
    has_many :journals, :through => :postings

    class << self
      def recalculate_all_balances
        warn "[DEPRECATION] `recalculate_all_balances` is deprecated and will be removed in a future version. Please use `recalculate_attributes` instead."

        recalculate_attributes
      end

      def recalculate_attributes
        find_each do |account|
          account.recalculate_attributes
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

    def balance
      if ActsAsAccount.configuration.persist_attributes_on_account
        super
      else
        postings.sum(:amount)
      end
    end

    def postings_count
      if ActsAsAccount.configuration.persist_attributes_on_account
        super
      else
        postings.count
      end
    end

    def last_valuta
      if ActsAsAccount.configuration.persist_attributes_on_account
        super
      else
        postings.maximum(:valuta)
      end
    end

    def recalculate_attributes
      return unless ActsAsAccount.configuration.persist_attributes_on_account

      update_columns(
        last_valuta:    postings.maximum(:valuta),
        balance:        postings.sum(:amount),
        postings_count: postings.count
      )
    end

    def deleteable?
      postings.empty? && journals.empty?
    end
  end
end

class Account < ActiveRecord::Base
  self.table_name = :acts_as_account_accounts

  belongs_to :holder, :polymorphic => true
  has_many :postings, :class_name => 'Posting'
  has_many :journals, :through => :postings
  attr_accessible :name

  # TODO: discuss with norman:
  # validates_presence_of will force an ActiveRecord::find on the object
  # but we have to create accounts for deleted holder!
  #
  # validates_presence_of :holder

  class << self

    def recalculate_all_balances
      Account.update_all(:balance => 0, :postings_count => 0, :last_value => nil)
      sql = <<-EOT
      SELECT
        account_id as id,
        count(*) as calculated_postings_count,
        sum(amount) as calculated_balance,
        max(value) as calculated_value
      FROM
        acts_as_account_postings
      GROUP BY
        account_id
      HAVING
        calculated_postings_count > 0
      EOT

      Account.find_by_sql(sql).each do |account|
        account.lock!
        account.update_attributes(
          :balance => account.calculated_balance,
          :postings_count => account.calculated_postings_count,
          :last_value => account.calculated_value)

        puts "account:#{account.id}, balance:#{account.balance}, postings_count:#{account.postings_count}, last_value:#{account.last_value}"
      end
    end

    def for(name)
      GlobalAccount.find_or_create_by_name(name.to_s).account
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
    rescue ActiveRecord::StatementInvalid => e
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

  def deleteable?
    postings.empty? && journals.empty?
  end
end

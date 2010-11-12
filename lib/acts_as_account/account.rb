module ActsAsAccount
  class Account < ActiveRecord::Base
    set_table_name :acts_as_account_accounts
    
    belongs_to :holder, :polymorphic => true
    has_many :postings
    has_many :journals, :through => :postings

    # TODO: discuss with norman: 
    # validates_presence_of will force an ActiveRecord::find on the object
    # but we have to create accounts for deleted holder!
    #
    # validates_presence_of :holder
    
    class << self
      
      def recalculate_all_balances
        ActsAsAccount::Account.update_all(:balance => 0, :postings_count => 0, :last_valuta => nil)
        sql = <<-EOT
        SELECT 
          account_id as id, 
          count(*) as calculated_postings_count,
          sum(amount) as calculated_balance,
          max(valuta) as calculated_valuta
        FROM
          acts_as_account_postings 
        GROUP BY 
          account_id 
        HAVING 
          calculated_postings_count > 0
        EOT

        ActsAsAccount::Account.find_by_sql(sql).each do |account|
          account.lock!
          account.update_attributes(
            :balance => account.calculated_balance, 
            :postings_count => account.calculated_postings_count,
            :last_valuta => account.calculated_valuta)

          puts "account:#{account.id}, balance:#{account.balance}, postings_count:#{account.postings_count}, last_valuta:#{account.last_valuta}"
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
          find(:first, :conditions => [
            "holder_type = ? and holder_id = ? and name = ?",
            attributes[:holder_type], attributes[:holder_id], attributes[:name]
          ])
        end
        record || raise
      end
    end

    def deleteable?
      postings.empty? && journals.empty?
    end
  end
end

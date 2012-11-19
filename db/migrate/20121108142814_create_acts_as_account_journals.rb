class CreateActsAsAccountJournals < ActiveRecord::Migration
  def change
    create_table "acts_as_account_journals", :force => true do |t|
      t.timestamps
    end
  end
end

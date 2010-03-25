Given /^I create a user (\w+)$/ do |name|
  User.create!(:name => name)
end

Given /^I create a global ([_\w]+) account$/ do |name|
  ActsAsAccount::Account.for(name)
end

Then /^an account for user (\w+) exists$/ do |name|
  @account = User.find_by_name(name).account
  assert_not_nil @account
end

Then /^the account has (\d+) journals?$/ do |num_journals|
  num_journals = num_journals.to_i
  
  if num_journals == 1
    @journal = @account.journals.first
  else
    @journals = @account.journals
  end
    
  assert_equal num_journals, @account.journals.count
end

Then /^the journal has (\d+) postings? with an amount of (\d+) €$/ do |num_postings, amount|
  @postings = @journal.postings
  assert_equal num_postings.to_i, @postings.size
  @postings.each do |posting|
    assert_equal amount.to_i, posting.amount
  end
end

Then /^(\w+)'s account balance is (-?\d+) €$/ do |name, balance|
  assert_equal balance.to_i, User.find_by_name(name).account.balance
end

Then /^the global (\w+) account balance is (-?\d+) €$/ do |name, balance|
  assert_equal balance.to_i, ActsAsAccount::Account.for(name).balance
end

When /^I transfer (\d+) € from (\w+)'s account to (\w+)'s account$/ do |amount, from, to|
  from_account = User.find_by_name(from).account
  to_account = User.find_by_name(to).account
  ActsAsAccount::Journal.current.transfer(amount.to_i, from_account, to_account, @reference)
end

When /^I transfer (\d+) € from global (\w+) account to global (\w+) account$/ do |amount, from, to|
  from_account = ActsAsAccount::Account.for(from)
  to_account = ActsAsAccount::Account.for(to)
  ActsAsAccount::Journal.current.transfer(amount.to_i, from_account, to_account, @reference)
end
 
When "I commit" do
  ActsAsAccount::Journal.current.commit
end

When /^I don't commit$/ do
  # does nothing
end

Then /^the balance\-sheet should be:$/ do |table|
  table.hashes.each do |row|
    assert_equal row['Balance'].to_i, User.find_by_name(row['User']).account.balance
  end
end

Then /^the current Journal should know there are uncommited transfers$/ do
  assert ActsAsAccount::Journal.current.uncommitted?
end

Then /^the Journal should know all transfers were committed$/ do
  assert !ActsAsAccount::Journal.current.uncommitted?
end

When "I clear the Journal" do
  @last_exception = nil
  begin
    ActsAsAccount::Journal.clear_current
  rescue Exception => @last_exception
  end
end

Then /^I fail with (.+)$/ do |exception|
  assert_equal exception.constantize, @last_exception.class
end

When /^I create a Journal via (.+)$/ do |method|
  @last_exception = nil
  begin
    eval <<-EOT
    @journal = ActsAsAccount::Journal.#{method}
    EOT
  rescue Exception => @last_exception
  end
end

Then /^I have a Journal$/ do
  assert_equal ActsAsAccount::Journal, @journal.class
end

Then /^User (\w+) has an Account named (\w+)$/ do |user_name, account_name|
  @account = User.find_by_name(user_name).account
  assert_equal account_name, @account.name
end

Given /^I create an Account named (\w+) for User (\w+)$/ do |account_name, user_name|
  user = User.find_by_name(user_name)
  @created_account = ActsAsAccount::Account.create!(:holder => user, :name => account_name)
end

Then /^I get the original account$/ do
  assert_equal @account, @created_account
end

Given /I transfer (\d+) € from (\w+)'s account to (\w+)'s account referencing a (\w+) with (\w+) (\w+)$/ do |amount, from, to, reference, name, value|
  @reference = reference.constantize.create!(name => value)
  Given "I transfer #{amount} € from #{from}'s account to #{to}'s account"
end

Then /^all postings reference (\w+) with (\w+) (\w+)$/ do |reference_class, name, value|
  reference = reference_class.constantize.find(:first, :conditions => "#{name} = #{value}")
  ActsAsAccount::Posting.all.each do |posting|
    assert_equal reference, posting.reference 
  end
end


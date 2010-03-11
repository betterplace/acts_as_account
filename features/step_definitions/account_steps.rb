Given /^I create a user (\w+)$/ do |name|
  User.create!(:name => name)
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

Then /^(\w+)'?s? account balance is (-?\d+) €$/ do |name, balance|
  account = (name == 'the' ? @account : User.find_by_name(name).account)
  assert_equal balance.to_i, account.balance
end

When /^I transfer (\d+) € from (\w+)'s account to (\w+)'s account$/ do |amount, from, to|
  @journal ||= ActsAsAccount::Journal.create
  from_account = User.find_by_name(from).account
  to_account = User.find_by_name(to).account
  @journal.transfer(amount.to_i, from_account, to_account)
end
 
When "I commit" do
  @journal.commit
end

When /^I don't commit$/ do
  # do nothing
end

Then /^the balance\-sheet should be:$/ do |table|
  table.hashes.each do |row|
    assert_equal row['Balance'].to_i, User.find_by_name(row['User']).account.balance
  end
  # table is a Cucumber::Ast::Table
end

# encoding: utf-8

include ActsAsAccount

require 'rspec'
RSpec.configure do |config|
  config.expect_with(:rspec) { |c| c.syntax = :should }
end

def german_date_time_to_local(datestring, timestring)
  Time.local(*(datestring.split(".").reverse + timestring.split(":")).map(&:to_i))
end

Given /^I create a user (\w+)$/ do |name|
  User.create!(:name => name)
end

Given /^I have a user (\w+) that inherits from an abstract class$/ do |name|
  InheritingUser.create!(:name => name)
end

Given /^I autocreate an account for inheriting user (\w+)$/ do |name|
  @created_account = InheritingUser.find_by_name(name).account
  @created_account.should_not be_nil
end

Then /^the account of user (\w+) should be there$/ do |name|
  account = InheritingUser.find_by_name(name).account
  @created_account.should eq account
end

Given /^I create a global ([_\w]+) account$/ do |name|
  Account.for(name)
end

Then /^an account for user (\w+) exists$/ do |name|
  @account = User.find_by_name(name).account
  @account.should_not be_nil
end

Then /^the account has (\d+) journals?$/ do |num_journals|
  num_journals = num_journals.to_i

  if num_journals == 1
    @journal = @account.journals.first
  else
    @journals = @account.journals
  end

  num_journals.should eq @account.journals.count
end

Then /^the journal has (\d+) postings? with an amount of (\d+) €$/ do |num_postings, amount|
  @postings = @journal.postings
  num_postings.to_i.should eq @postings.size
  @postings.each do |posting|
    amount.to_i.should eq posting.amount
  end
end

Then /^(\w+)'s account balance is (-?\d+) €$/ do |name, balance|
  balance.to_i.should eq User.find_by_name(name).account.balance
end

Then /^the global (\w+) account balance is (-?\d+) €$/ do |name, balance|
  balance.to_i.should eq Account.for(name).balance
end

When /^I transfer (-?\d+) € from (\w+)'s account to (\w+)'s account$/ do |amount, from, to|
  from_account = User.find_by_name(from).account
  to_account = User.find_by_name(to).account
  Journal.current.transfer(amount.to_i, from_account, to_account, @reference, @valuta)
end

When /^I transfer (\d+) € from global (\w+) account to global (\w+) account$/ do |amount, from, to|
  from_account = Account.for(from)
  to_account = Account.for(to)
  Journal.current.transfer(amount.to_i, from_account, to_account, @reference, @valuta)
end

Then /^the balance\-sheet should be:$/ do |table|
  table.hashes.each do |row|
    row['Balance'].to_i.should eq User.find_by_name(row['User']).account.balance
  end
end

Then /^I fail with (.+)$/ do |exception|
  exception.constantize.should eq @last_exception.class
end

When /^I create a Journal via (.+)$/ do |method|
  @last_exception = nil
  begin
    eval <<-EOT
    @journal = Journal.#{method}
    EOT
  rescue => @last_exception
  end
end

Then /^I have a Journal$/ do
  Journal.should eq @journal.class
end

Then /^User (\w+) has an Account named (\w+)$/ do |user_name, account_name|
  @account = User.find_by_name(user_name).account
  account_name.should eq @account.name
end

Given /^I create an Account named (\w+) for User (\w+)$/ do |account_name, user_name|
  user = User.find_by_name(user_name)
  @created_account = Account.create!(:holder => user, :name => account_name)
end

Then /^I get the original account$/ do
  @account.should eq @created_account
end

Then(/^I can get the (\w+) Account of User (\w+)$/) do |account_name, user_name|
  account = User.find_by_name(user_name).__send__(:"#{account_name}_account")
  account.should be_kind_of ActsAsAccount::Account
end

Given /I transfer (\d+) € from (\w+)'s account to (\w+)'s account referencing a (\w+) with (\w+) (\w+)$/ do |amount, from, to, reference, name, value|
  @reference = reference.constantize.create!(name => value)
  step "I transfer #{amount} € from #{from}'s account to #{to}'s account"
end

Then /^all postings reference (\w+) with (\w+) (\w+)$/ do |reference_class, name, value|
  reference = reference_class.constantize.where("#{name} = #{value}").first
  Posting.all.each do |posting|
    reference.should eq posting.reference
  end
end

Given /^I transfer (\d+) € from (\w+)'s account to (\w+)'s account and specify (\S+) (\S+) as the booking time$/ do |amount, from, to, booking_date, booking_time|
  @valuta = german_date_time_to_local(booking_date, booking_time)
  step "I transfer #{amount} € from #{from}'s account to #{to}'s account"
end

Then /^all postings have (\S+) (\S+) as the booking time$/ do |booking_date, booking_time|
  valuta = german_date_time_to_local(booking_date, booking_time)
  Posting.all.each do |posting|
    valuta.should eq posting.valuta
  end
end

Then /^(\w+) with (\w+) (\w+) references all postings$/ do |reference_class, name, value|
  reference = reference_class.constantize.where("#{name} = #{value}").first
  Posting.all.to_a.should eq reference.postings
end

Then /^the order of the postings is correct$/ do
  # make sure we always book "Soll an Haben"
  Posting.all.each_slice(2) do |from, to|
    from.amount.should be < 0
    to.amount.should be > 0
  end
end

Given /^I have the same user in memory$/ do
  @user1 = User.first
  @user2 = User.find(@user1.id)
end

Given /^I disable the account existence check on those$/ do
  [@user1, @user2].each do |user|
    user.instance_eval "def default_account; true; end"
  end
end

When /^I call 'account' on both it should be possible$/ do
  [@user1, @user2].each { |user| user.account }
end

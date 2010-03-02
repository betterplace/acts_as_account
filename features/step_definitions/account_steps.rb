Given /^I create an account for user (\w+) with (\d+) €$/ do |name, opening_balance|
  user = User.create!(:name => name)
  user.create_account(:opening_balance => opening_balance)
end

Then /^an account for user (\w+) exists$/ do |name|
  assert_not_nil User.find_by_name(name).account
end

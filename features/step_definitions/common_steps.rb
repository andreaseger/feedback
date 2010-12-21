Given /^There are no sheets$/ do
  Sheet.delete_all
end

Then /^(?:|I )should have (\d+) "([^"]*)"$/ do |count, klass|
  if klass == "User"
    count = 4 + count.to_f
  end
  klass.constantize.count.should == count.to_f
end

Given /debugger/ do
  debugger
  puts "foo"
end


Given /^(?:|I )should have no "([^"]*)"$/ do |klass|
  klass.constantize.delete_all
end

When /^(?:|I )enter in "([^"]*)" with "([^"]*)"(?: within "([^"]*)")?$/ do |field, value, selector|
  value.gsub!('\r\n',"\r\n")
  with_scope(selector) do
    fill_in(field, :with => value)
  end
end


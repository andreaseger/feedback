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


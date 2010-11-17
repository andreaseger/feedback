Given /^(?:I )have no sheets$/ do
  Sheet.delete_all
end

Then /^(?:I )should have (\d+) "([^"]*)"$/ do |count, klass|
  klass.constantize.count.should == count.to_f
end


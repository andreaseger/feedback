Then /^I should have a Semester for "([^"]*)" (\d+)$/ do |type, year|
  Semester.last.year.should == year
  if type.match(/ss/i)
    Semester.last.ws.should be_false
  else
    Semester.last.ws.should be_true
  end
end


Then /^the Semester should have (\d+) interns$/ do |num|
  Semester.last.should have(num.to_i).interns
end

Then /^the interns should be the following:$/ do |table|
  Semester.last.interns.each do |intern|
    table.should.include?(intern.nds)
  end
end


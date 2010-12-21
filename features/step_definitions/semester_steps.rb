Then /^I should have a Semester for "([^"]*)" (\d+)$/ do |type, year|
  if type.match(/ss/i)
    semester = Semester.where(:year => year.to_i, :ws => false).first
  else
    semester = Semester.where(:year => year.to_i, :ws => true).first
  end
  semester.should_not be_nil
end


Then /^the Semester "([^"]*)" (\d+) should have (\d+) interns$/ do |type, year, num|
  if type.match(/ss/i)
    semester = Semester.where(:year => year.to_i, :ws => false).first
  else
    semester = Semester.where(:year => year.to_i, :ws => true).first
  end
  semester.interns.count.should == num.to_i
end

Then /^the Semester "([^"]*)" (\d+) should have this interns:$/ do |type, year, table|
  if type.match(/ss/i)
    semester = Semester.where(:year => year.to_i, :ws => false).first
  else
    semester = Semester.where(:year => year.to_i, :ws => true).first
  end
  semester.interns.each do |intern|
    table.raw.flatten.include?(intern.nds).should be_true
  end
end


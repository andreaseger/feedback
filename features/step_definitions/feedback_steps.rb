Given /The user "([^\"]*)" has a sheet/ do |user|
  user = User.where(:nds => user).first
  Factory(:full_sheet, :user => user)
end

Given /The user "([^\"]*)" has no sheet/ do |user|
  user = User.where(:nds => user).first
  user.sheet = nil
  user.save
end


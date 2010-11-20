Given /(?:|I ) have a sheet/ do
  Factory(:full_sheet, :user => User.last)
end

Given /(?:|I ) have no sheet/ do
  User.last.sheet = nil
end


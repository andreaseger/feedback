Given /^(?:|I )have one\s+user "([^\"]*)" with password "([^"]*)" and the roles "([^\"]*)"$/ do |nds, password, roles|
  email = "#{nds.to_s}@abc.com"
  User.create!(:nds => nds,
           :email => email,
           :roles => roles.split(' '))
end

Given /^(?:|I )am a new, authenticated (admin|student|intern|prof)(?: with nds "([^\"]*)"(?: and password "([^\"]*)")?)?$/ do |type, nds, password|
  nds = "joe#{rand(99999)}" unless nds
  password = 'secretpass' unless password
  case type
  when "admin"
    roles = "admin"
  when "student"
    roles = "student"
  when "intern"
    roles = "student:intern"
  when "prof"
    roles = "prof"
  end

  Given %{I have one user "#{nds}" with password "#{password}" and the roles "#{roles}"}
  And %{I go to login}
  And %{I fill in "user_nds" with "#{nds}"}
  And %{I fill in "user_password" with "#{password}"}
  And %{I press "Sign in"}
end

Then /^I should have a user "([^"]*)" with the role "([^"]*)"$/ do |user, role|
  u = User.where(:nds => user).first
  u.role?(role).should be_true
end


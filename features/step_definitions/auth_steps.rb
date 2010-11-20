Given /^(?:|I )have one\s+user "([^\"]*)" with password "([^\"]*)" and the roles "([^\"]*)"$/ do |email, password, roles|
  User.create!(:email => email,
           :password => password,
           :password_confirmation => password,
           :roles => roles.split(':'))
end

Given /^(?:|I )am a new, authenticated (admin|student|intern|prof)(?: with email "([^\"]*)"(?: and password "([^\"]*)")?)?$/ do |type, email, password|
  email = 'testing@man.net' unless email
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

  Given %{I have one user "#{email}" with password "#{password}" and the roles "#{roles}"}
  And %{I go to login}
  And %{I fill in "user_email" with "#{email}"}
  And %{I fill in "user_password" with "#{password}"}
  And %{I press "Sign in"}
end


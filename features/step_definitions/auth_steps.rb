Given /^(?:|I )have one\s+user "([^\"]*)" with the roles "([^\"]*)"$/ do |nds, roles|
  User.create!(:nds => nds, :roles => roles.split(' '))
end

#Given /^(?:|I )am a new, authenticated (admin|student|intern|prof)(?: with nds "([^\"]*)")?$/ do |type, nds|
#  nds = "joe#{rand(99999)}" unless nds
#  password = 'secretpass'
#
#  @user = Factory(type.to_sym, :nds => nds, :cached_dn => 'foo')
#  @ldap = Ldap.new
#  @ldap.stubs(:authenticate).returns(true)
#  Ldap.stubs(:new).returns(@ldap)
#  User.stubs(:where).returns([@user])
#
#  Given %{I go to login}
#  And %{I fill in "user_nds" with "#{nds}"}
#  And %{I fill in "user_password" with "#{password}"}
#  And %{I press "Login"}
#end

Then /^I should have a user "([^"]*)" with the role "([^"]*)"$/ do |user, role|
  u = User.where(:nds => user).first
  u.role?(role).should be_true
end

Given /I am authenticated as "([^\"]*)"/ do |role|
  password = LDAP_CONFIG["backdoor"]

  Given %{I go to login}
  And %{I fill in "user_nds" with "#{role}"}
  And %{I fill in "user_password" with "#{password}"}
  And %{I press "Login"}
end


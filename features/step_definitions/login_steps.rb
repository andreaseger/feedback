Given /^I am a authenticated admin with nds "([^"]*)"$/ do |nds|
#Given /^(?:|I )am a authenticated(admin|student|intern|prof)(?: with nds "([^\"]*)")?$/ do |role, nds|
  role ='admin'
  if nds
    user = Factory(role.to_sym, :nds => nds)
  else
    user = Factory(role.to_sym)
  end
  @controller.stubs(:user_signed_in?).returns(true)
  @controller.stubs(:current_user).returns(user)
end


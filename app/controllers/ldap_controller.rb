class LdapController < ApplicationController

  def login
  end

  def create
    @user = User.find_for_ldap(params[:user])
    if @user.persisted?
      flash[:notice] = "Login successfull"
      sign_in_and_redirect @user
    else
      flash[:error] = "Login failed"
      redirect_to login_path
    end
  end

end


class UsersController < ApplicationController
  def new
    @user = User.new_with_ldap(session[:user_info])
  end

  def create
    user = User.new_with_ldap(session[:user_info])
    user.matnr = params[:user][:matnr]
    if user.save
      session[:user_id] = user.id
      session[:user_info] = nil
      redirect_to root_url, :notice => "Successfully logged in!"
    else
      render :new, :error => "Login failed"
    end
  end
end


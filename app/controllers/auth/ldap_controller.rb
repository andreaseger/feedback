class Auth::LdapController < ApplicationController
  def index
  end

  def create
    render :text => request.env["omniauth.auth"].to_yaml
  end

  def destroy
  end

  def failure
    render :text => params[:message]
  end
end


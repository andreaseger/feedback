class SessionsController < ApplicationController
  before_filter :authenticate!, :only => :destroy
  def new
    #shows the login form
  end

  def create
    nds = params[:user][:nds]
    password = params[:user][:password]
    # look if a user with that nds exists
    user = User.where(:nds => nds).first

    # dev-test backdoor
    #---------------------------------------------
      if %w(admin student intern extern).member?(nds) && password == LDAP_CONFIG["backdoor"]
        session[:user_id] = user.id
        redirect_to root_url, :notice => "Yeeha you slipped through the backdoor"
        return
      end
    #---------------------------------------------
    ldap = Ldap.new
    if user && user.dn
      if ldap.authenticate(user.dn, password)
        # successfully authenticated
        session[:user_id] = user.id
        redirect_to root_url, :notice => "Successfully logged in!"
      else
        # failure
        redirect_to new_session_url, :error => "Login failed"
      end
    else
      data = ldap.fetchData(nds)
      if ldap.authenticate(data.dn, password)
        # successfully authenticated
        user = User.create_with_ldap!(data)
        if user
          session[:user_id] = user.id
          redirect_to root_url, :notice => "Successfully logged in!"
        else
          redirect_to new_session_url, :error => "Login failed - If this happends again you should probably contact the admin"
        end
      else
        # failure
        redirect_to new_session_url, :error => "Login failed"
      end
    end
  end

  def destroy
    session[:user_id] = nil
  end
end


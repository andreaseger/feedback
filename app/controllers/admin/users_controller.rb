class Admin::UsersController < InheritedResources::Base
  before_filter :authenticate_user!, :except => [:edit_multiple, :update_multiple]
  load_and_authorize_resource :except => [:edit_multiple, :update_multiple]
  before_filter :auth_admin_for_multiple, :only => [:edit_multiple, :update_multiple]
  before_filter :remove_empty_roles, :only => [:update, :update_multiple]

  actions :all, :except => [:show, :new, :create, :destroy]

  has_scope :with_role

  def index
    @users = apply_scopes(User).all
  end

  def update
    update!{ collection_url }
  end

  def edit_multiple
    if @users.count == 1
      # render the normal edit form if only one user is selected
      @user = @users.first
      render :edit
    else
      @user = User.new(:roles => @users.map{|u| u.roles}.inject(:&))
    end
  end

  def update_multiple
    @users.each do |user|
      unless user.update_attributes(params[:user])
        flash[:error] = user.errors.full_messages.join("\n")
        @user = User.new(:roles => @users.map{|u| u.roles}.inject(:&))
        render :edit_multiple
        return
      end
    end
    flash[:notice] = "Updated users!"
    redirect_to collection_url
  end

  private
  def auth_admin_for_multiple
    user_signed_in?
    authorize! :manage, User
    @users = User.find(params["user_ids"])
  end
  def remove_empty_roles
    params[:user][:roles].delete_if{|r| r.empty?} if params[:user][:roles]
  end
end

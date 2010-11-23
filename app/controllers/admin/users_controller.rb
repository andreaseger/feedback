class Admin::UsersController < InheritedResources::Base
  before_filter :authenticate_user!
  load_and_authorize_resource

  actions :all, :except => [:new, :create, :destroy]

  has_scope :with_role

  def index
    @users = apply_scopes(User).all
  end

  def update
    # delete empty string
    params[:user][:roles].delete_if{|r| r.empty?}
    update!{ collection_url }
  end

end


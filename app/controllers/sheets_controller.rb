class SheetsController < InheritedResources::Base
  #belongs_to :user, :singleton => true
  before_filter :authenticate_user!
  load_and_authorize_resource

  def new
    @sheet.application_address = Address.new()
    @sheet.job_site_address = Address.new()
  end
  def create
    @sheet.user = current_user
    create!
  end
end


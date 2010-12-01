class SheetsController < InheritedResources::Base
  before_filter :authenticate!
  load_and_authorize_resource

  def new
    @sheet.build_application_address()
    @sheet.build_job_site_address()
  end
  def create
    @sheet.user = current_user
    create!
  end
end


class SheetsController < InheritedResources::Base
  before_filter :authenticate!
  load_and_authorize_resource :except => :search

  def index
    @sheets = Sheet.desc(:osemester).paginate(:per_page => 20, :page => params[:page])
  end

  def new
    @sheet.build_application_address()
    @sheet.build_job_site_address()
  end
  def create
    @sheet.user = current_user
    create!
  end

  def update
    update!
  end

  def search
    authorize! :read, Sheet
    if params[:search]
      s = params[:search].reject{ |key, value| value.empty? }
      @sheets = Sheet.search(s)#.paginate(:per_page => 1, :page => params[:page])
      @search = Sheet.new(s)
    end
  end
end


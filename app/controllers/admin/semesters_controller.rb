class Admin::SemestersController < InheritedResources::Base
  before_filter :authenticate!
  load_and_authorize_resource
  actions :all, :except => [:destroy]
  def index
    @semesters = Semester.desc(:year).desc(:ws).paginate(:per_page => 5, :page => params[:page])
  end
  #def create
  #  debugger
  #  create!
  #end
#
  #def update
  #  debugger
  #  update!
  #end
end


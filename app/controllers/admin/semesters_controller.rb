class Admin::SemestersController < InheritedResources::Base
  before_filter :authenticate!
  load_and_authorize_resource
  actions :all, :except => [:destroy]
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


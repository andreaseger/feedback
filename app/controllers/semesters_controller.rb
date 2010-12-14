class SemestersController < InheritedResources::Base
  before_filter :authenticate!
  load_and_authorize_resource
  actions :all, :except => [:destroy]
end


class Semester
  include Mongoid::Document
  field :text
  field :sort
  field :interns, :type => Array

  validates_presence_of :text, :sort, :interns

  def internslist

  end

  def internslist=(value)

  end
end


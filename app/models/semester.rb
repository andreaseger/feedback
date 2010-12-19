class Semester
  include Mongoid::Document
  cache
  field :year, :type => Integer
  field :ws, :type => Boolean

  field :interns, :type => Array

  references_many :sheets

  validates_presence_of :year
  validates_inclusion_of :ws, :in => [true, false]

  def internslist
    interns.join("\n")
  end

  def internslist=(value)
    self.interns = value.split("\n")
  end

  def text
    if ws
      "WS#{text_year}"
    else
      "SS#{text_year}"
    end
  end

  def long_text
    if ws
      "Wintersemester #{text_year}"
    else
      "Sommersemester #{text_year}"
    end
  end

private

  def text_year
    if ws
      "#{year}/#{(year+1).to_s.slice(-2..-1)}"
    else
      "#{year}"
    end
  end
end


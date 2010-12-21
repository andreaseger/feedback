class Semester
  include Mongoid::Document
  cache
  field :year, :type => Integer
  field :ws, :type => Boolean

  references_many :interns, :class_name => 'User', :stored_as => :array, :inverse_of => :semesters

  references_many :sheets

  validates_presence_of :year
  validates_inclusion_of :ws, :in => [true, false]
  validates_uniqueness_of :year, :scope => :ws

  def matrlist
    interns.map(&:matnr).join("\n")
  end

  def matrlist=(value)
    m=value.split("\n").map{|i| i.chomp}
    #debugger
    self.interns = User.any_in(:matnr => m).asc(:matnr).entries
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

#class method

  def self.current
    date = Date.today
    year = date.year
    if date.month >= 3 && date.month <= 9
      # Sommersemester
      flag = false
    else
      # Wintersemester
      flag = true
      if date.month < 3
        year = date.year - 1
      end
    end
    find_or_create_by(:year => year, :ws => flag)
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


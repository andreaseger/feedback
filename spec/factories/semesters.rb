FactoryGirl.define do
  factory :semester do
    year 1990
    ws false
  end
  factory :ws2009, :class => :semester do
    year 2009
    ws true
  end
end


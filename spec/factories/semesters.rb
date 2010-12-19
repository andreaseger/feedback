FactoryGirl.define do
  factory :semester do
    year 1990
    ws false
  end
  factory :ws2010, :class => :semester do
    year 2010
    ws true
  end
end


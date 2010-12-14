FactoryGirl.define do
  factory :semester do
    text "SS1990"
    sort "1990.1"
    interns ['1231222','1231221']
  end
  factory :ws2010, :class => :semester do
    text "WS2010/11"
    sort "2010.2"
    interns ['1231231','1231232']
  end
end


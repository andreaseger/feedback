FactoryGirl.define do
  factory :sheet do
    semester {Factory(:ws2010)}
  end

  factory :valid_sheet, :class => :sheet  do
    company "BMW"
    boss  "Mr White"
    handler "Mr Black"
    intership_length  18
    reachability 2
    accessibility 1
    working_atmosphere 3
    satisfaction_with_support 2
    stress_factor 4
    apartment_market 2
    satisfaction_with_internship 1
    big_project true
    independent_work 4
    reference_to_the_study 2
    learning_effect 3
    required_previous_knowledge 3
  end


  factory :full_sheet, :parent => :valid_sheet do
    association :semester, :factory => :semester
    application_address {Factory.attributes_for(:application_address)}
    job_site_address  {Factory.attributes_for(:job_site_address)}
    department  "ER TD HT FB"
    note_company "Lorem Ipsum"
    intership_length  18
    extendable  true
    vacation false
    release true
    working_hours 42
    flextime true
    salary 523
    required_languages "greek"
    note_conditions "Cloverfield"
    percentage_of_women 53
    note_personal_impression "Inception"
    teamsize 13
    note_project "Flash of Genius"
    note_general "Machete"
  end
end


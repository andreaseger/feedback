Factory.define :sheet do |f|
  f.semester "ss1942"
end

Factory.define :valid_sheet, :class => :sheet  do |f|
  f.semester "WS2010/11"
  f.company "BMW"
  f.boss  "Mr White"
  f.handler "Mr Black"
  f.intership_length  18
  f.reachability 2
  f.accessibility 1
  f.working_atmosphere 3
  f.satisfaction_with_support 2
  f.stress_factor 4
  f.apartment_market 2
  f.satisfaction_with_internship 1
  f.big_project true
  f.independent_work 4
  f.reference_to_the_study 2
  f.learning_effect 3
  f.required_previous_knowledge 3
end


Factory.define :full_sheet, :parent => :valid_sheet do |f|
  f.application_address {Factory.attributes_for(:application_address)}
  f.job_site_address  {Factory.attributes_for(:job_site_address)}
  f.department  "ER TD HT FB"
  f.note_company "Lorem Ipsum"
  f.intership_length  18
  f.extendable  true
  f.vacation false
  f.release true
  f.working_hours 42
  f.flextime true
  f.salary 523
  f.required_languages "greek"
  f.note_conditions "Cloverfield"
  f.percentage_of_women 53
  f.note_personal_impression "Inception"
  f.teamsize 13
  f.note_project "Flash of Genius"
  f.note_general "Machete"
end


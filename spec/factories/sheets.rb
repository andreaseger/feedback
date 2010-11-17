Factory.define :sheet do |f|
  f.semester "ss1942"
end

Factory.define :full_sheet, :class => :sheet do |f|
  f.semester  "a"
  f.company   "b"
  f.address_application "c"
  f.job_site  "d"
  f.department  "e"
  f.boss  "f"
  f.handler "g"
  f.note_company "h"
  f.intership_length  18
  f.extention  true
  f.vacation false
  f.release true
  f.working_hours 42
  f.flextime true
  f.salary 523
  f.required_languages "i"
  f.reachability 2
  f.accessibility 1
  f.note_conditions "j"
  f.percentage_of_women 53
  f.working_atmosphere 3
  f.satisfaction_with_support 2
  f.stress_factor 4
  f.apartment_market 2
  f.satisfaction_with_internship 1
  f.note_personal_impression "k"
  f.big_project true
  f.teamsize 13
  f.independent_work 4
  f.reference_to_the_study 2
  f.learning_effect 3
  f.required_previous_knowledge 3
  f.note_project "l"
  f.note_general "m"
end


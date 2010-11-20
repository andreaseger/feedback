Feature: managing sheets

# wegen der Pflichtattribute nicht mehr sinnvoll
#Scenario Outline: Show me the Attributes
#  Given I have a "Sheet" with "<attribut>" equals "<value>"
#   When I am on the sheets show page
#   Then I should see "<value>"
#
#  Examples:
#    | attribut            | value     |
#    | company             | Audi      |
#    | semester            | SS2009    |
#    | salary              | 750       |
#    | intership_length    | 20        |
#    | required_languages  | spanish   |

Scenario: Creating a new sheet
  Given I have no sheets
    And I am on the homepage
   When I follow "New Sheet"
    And fill in the following:
      | sheet_semester                      | SS1999                |
      | sheet_company                       | Siemens               |
      | sheet_application_address_street    | Foostr 23             |
      | sheet_application_address_city      | Agrestic              |
      | sheet_application_address_post_code | 83642                 |
      | sheet_job_site_address_street       | Barstr 23             |
      | sheet_job_site_address_city         | Boston                |
      | sheet_job_site_address_post_code    | 49242                 |
      | sheet_department                    | ST WP AS              |
      | sheet_boss                          | Mr Black              |
      | sheet_handler                       | Mr White              |
      | sheet_note_company                  | Lorem Ipsum           |
      | sheet_intership_length              | 18                    |
      | sheet_working_hours                 | 42                    |
      | sheet_salary                        | 780                   |
      | sheet_required_languages            | greek                 |
      | sheet_note_conditions               | In id nisi dolor      |
      | sheet_percentage_of_women           | 45                    |
      | sheet_note_personal_impression      | Aliquam a tellus      |
      | sheet_teamsize                      | 42                    |
      | sheet_note_project                  | Nulla nunc ligula     |
      | sheet_note_general                  | Class aptent taciti   |
    And select "Egypt" from "sheet_application_address_country"
    And select "United States" from "sheet_job_site_address_country"
    And choose "sheet_extention_true"
    And choose "sheet_vacation_false"
    And choose "sheet_release_true"
    And choose "sheet_flextime_true"
    And choose "sheet_big_project_true"

    And choose "sheet_reachability_1"
    And choose "sheet_accessibility_3"
    And choose "sheet_working_atmosphere_1"
    And choose "sheet_satisfaction_with_support_4"
    And choose "sheet_stress_factor_3"
    And choose "sheet_apartment_market_1"
    And choose "sheet_satisfaction_with_internship_2"
    And choose "sheet_independent_work_4"
    And choose "sheet_reference_to_the_study_3"
    And choose "sheet_learning_effect_4"
    And choose "sheet_required_previous_knowledge_1"
    And press "Create Sheet"
   Then I should have 1 "Sheet"
    And I should be on the last sheets show page


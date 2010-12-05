Feature: Create a sheet
  As a Intern
  I want to be able to edit my sheet

Background:
  Given I am authenticated as "intern"
    And The user "intern" has a sheet

@wip
Scenario: Edit my sheet
  Given I am on the sheets edit page
   When I fill in "sheet_boss" with "Mr Fox"
    And I fill in "sheet_application_address_attributes_city" with "Rostock"
    And I fill in "sheet_job_site_address_attributes_street" with "marktrasse"
    And I press "Update Sheet"
   Then I should see "Mr Fox"
    And I should see "Rostock"
    And I should see "marktrasse"


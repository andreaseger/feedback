Feature: Manage Intern
  As a Admin
  In order to have less work
  I want to be able to set the interns for the current semester in one simple step

Background:
  Given I have one user "amy11111" with the roles "student" and matnr "9111111"
    And I have one user "bob22222" with the roles "student" and matnr "9222222"
    And I have one user "joe33333" with the roles "student" and matnr "9333333"
    And I have one user "tom44444" with the roles "student" and matnr "9444444"
  Given I am authenticated as "admin"
    And I am on the semesters index page
  Given I should have no "Semester"

Scenario: Create a new Semester and add a list of Interns
  Given I follow "New Semester"
   When I select "2012" from "semester_year"
    And choose "semester_ws_false"
    And I enter in "semester_matrlist" with "9111111\r\n9333333\r\n9444444"
    And I press "Create Semester"
   Then I should have a Semester for "SS" 2012
    And the Semester "SS" 2012 should have 3 interns
    And the Semester "SS" 2012 should have this interns:
      | amy11111 |
      | joe33333 |
      | tom44444 |


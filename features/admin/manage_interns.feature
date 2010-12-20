Feature: Manage Intern
  As a Admin
  In order to have less work
  I want to be able to set the interns for the current semester in one simple step

Background:
  Given I have one user "amy11111" with the roles "student" and matnr "1111111"
    And I have one user "bob22222" with the roles "student" and matnr "2222222"
    And I have one user "joe33333" with the roles "student" and matnr "3333333"
    And I have one user "tom44444" with the roles "student" and matnr "4444444"
  Given I am authenticated as "admin"
    And I am on the interns admin page


Scenario: Create a new Semester and add a list of Interns
  Given I press "New Semester"
   When I select "2012" from "semester_year"
    And I select "Sommersemester" from "semester_ws"
    And I fill in "semester_internslist" with "1111111\n3333333\n4444444"
    And I press "Save"
   Then I should have a Semester for "SS" 2012
    And the Semester should have 3 interns
    And the interns should be the following:
      | amy11111 |
      | joe33333 |
      | tom44444 |


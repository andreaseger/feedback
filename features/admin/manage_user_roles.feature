Feature: Manage Users and thier Roles
  As a Admin user
  I want to be able to change the roles of one or many users

Background:
  #Given I am a new, authenticated admin with nds "foo12345"
  Given I am a authenticated admin with nds "foo12345"
    And I have one user "amy11111" with password "secret" and the roles "student"
    And I have one user "bob22222" with password "secret" and the roles "student intern"
    And I have one user "joe33333" with password "secret" and the roles "admin"
    And I have one user "tom44444" with password "secret" and the roles "prof"
    And I am on the user admin page

Scenario: Edit one User
   When I follow "Edit" within "#user_amy11111"
    And check "Intern"
    And press "Update User"
   Then I should be on the user admin page
    And I should have a user "amy11111" with the role "intern"

Scenario Outline: Scope Students
   When I follow "<role>"
   Then I should see "<positive>"
    And I should not see "<negative>"

  Examples:
    | role     | positive     | negative   |
    | Students | amy11111     | tom44444   |
    | Interns  | bob22222     | amy11111   |
    | Admins   | joe33333     | bob22222   |
    | Profs    | tom44444     | joe33333   |


Scenario: Edit multiple
  When I check "edit" within "#user_amy11111"
   And check "edit" within "#user_bob22222"
   And press "Edit Checked"
  Then the "user_roles_student" checkbox should be checked

Scenario: Edit multiple
  When I check "edit" within "#user_amy11111"
   And check "edit" within "#user_bob22222"
   And press "Edit Checked"
   And check "user_roles_intern"
   And press "Save User"
  Then I should have a user "amy11111" with the role "intern"
   And I should have a user "bob22222" with the role "intern"


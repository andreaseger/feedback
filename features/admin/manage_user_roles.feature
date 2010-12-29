Feature: Manage Users and thier Roles
  As a Admin user
  I want to be able to change the roles of one or many users

Background:
  Given I have one user "amy11111" with the roles "student"
    And I have one user "bob22222" with the roles "student intern"
    And I have one user "joe33333" with the roles "admin"
    And I have one user "tom44444" with the roles "extern"
  Given I am authenticated as "admin"
    And I am on the user admin page

Scenario: Edit one User
   When I follow "Edit" within "#user_amy11111"
    And check "Admin"
    And press "Update User"
   Then I should be on the user admin page
    And I should have a user "amy11111" with the role "admin"

Scenario Outline: Scope Students
   When I follow "<role>"
   Then I should see "<positive>"
    And I should not see "<negative>"

  Examples:
    | role     | positive     | negative   |
    | Students | amy11111     | tom44444   |
    | Interns  | bob22222     | amy11111   |
    | Admins   | joe33333     | bob22222   |
    | Extern   | tom44444     | joe33333   |


Scenario: roles which are shared between the users should be pre-checked
  When I check "edit" within "#user_amy11111"
   And check "edit" within "#user_bob22222"
   And press "Edit Checked"
  Then the "user_roles_student" checkbox should be checked

Scenario: Edit multiple
  When I check "edit" within "#user_amy11111"
   And check "edit" within "#user_bob22222"
   And press "Edit Checked"
   And check "user_roles_admin"
   And press "Save User"
  Then I should have a user "amy11111" with the role "admin"
   And I should have a user "bob22222" with the role "admin"


Feature: Manage Users and thier Roles
  As a Admin user
  I want to be able to change the roles of one or many users

Background:
  Given I am a new, authenticated admin
    And I have one user "alice@foo.bar" with password "secret" and the roles "student"
    And I have one user "bob@foo.bar" with password "secret" and the roles "student intern"
    And I have one user "amy@foo.bar" with password "secret" and the roles "admin"
    And I have one user "john@doe.bar" with password "secret" and the roles "prof"

Scenario: Edit one User
  Given I am on the user admin page
   When I follow "Edit alice@foo.bar"
    And check "Intern"
    And press "Update User"
   Then I should be on the user admin page
    And I should have a user "alice@foo.bar" with the role "intern"

Scenario Outline: Scope Students
  Given I am on the user admin page
   When I follow "<role>"
   Then I should see "<positive>"
    And I should not see "<negative>"

  Examples:
    | role     | positive        | negative      |
    | Students | alice@foo.bar   | amy@foo.bar   |
    | Interns  | bob@foo.bar     | alice@foo.bar |
    | Admins   | amy@foo.bar     | john@doe.bar  |
    | Profs    | john@doe.bar    | bob@foo.bar   |


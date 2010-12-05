Feature: Just testing the Backgrounder for the test

#Scenario: Create an login user
#  Given I am a new, authenticated admin with nds "foo12345"
#   Then I should have 1 "User"
#    And I should have a user "foo12345" with the role "admin"

Scenario: Create user with one roles
  Given I have one user "amy11111" with the roles "student"
   Then I should have 1 "User"
    And I should have a user "amy11111" with the role "student"

Scenario: Create user with multiple roles
  Given I have one user "amy11111" with the roles "student intern"
   Then I should have 1 "User"
    And I should have a user "amy11111" with the role "student"
    And I should have a user "amy11111" with the role "intern"


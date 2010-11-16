Feature: managing sheets

Scenario Outline: Show me the Attributes
  Given I have a "Sheet" with "<attribut>" equals "<value>"
   When I am on the sheets show page
   Then I should see "<value>"

  Examples:
    | attribut            | value     |
    | company             | Audi      |
    | semester            | SS2009    |
    | salary              | 750       |
    | intership_length    | 20        |
    | required_languages  | spanish   |


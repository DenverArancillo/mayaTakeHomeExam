# Test Automation:
# Using this Swagger doc: Cat Facts API, create an API automation framework running all endpoints. Consider writing positive and negative scenarios.
# https://catfact.ninja/#/

Feature: Cat Facts API

  # Endpoint /breeds

  Scenario: Verify that cat breeds API endpoint returns the correct number of items
    Given I send a request to get cat breeds with limit of "4" with status code 200
    Then Count of cat breeds should be 4
    And I send a request to get cat breeds with limit of "23" with status code 200
    Then Count of cat breeds should be 23
    And I send a request to get cat breeds with limit of "98" with status code 200
    Then Count of cat breeds should be 98

  Scenario: Verify that cat breeds API endpoint return all items given a limit exceeding the total count
    Given I send a request to get cat breeds with limit of "1000" with status code 200
    Then Count of cat breeds should be 98

  Scenario: Verify that cat breeds API endpoint returns 404 error when given a negative number
    Given I send a request to get cat breeds with limit of "-1" with status code 404
    Then Response message should be "Not Found"

  Scenario: Verify that cat breeds API endpoint returns default value for empty and incorrect limit parameter
    Given I send a request to get cat breeds with limit of "" with status code 200
    Then Count of cat breeds should be 25
    Given I send a request to get cat breeds with limit of "-13a" with status code 200
    Then Count of cat breeds should be 25

  # Endpoint /fact

  Scenario: Verify that cat fact API endpoint should return a fact with a length less than or equal to the max length given
    Given I send a request to get a cat fact with max length of "20" with status code 200
    Then Cat fact response length should be less than or equal to 20
    And I send a request to get a cat fact with max length of "53" with status code 200
    Then Cat fact response length should be less than or equal to 53

  Scenario: Verify that cat fact API endpoint returns empty response if given max length is below 20 or is a negative number
    Given I send a request to get a cat fact with max length of "19" with status code 200
    Then Cat fact reponse should be empty
    And I send a request to get a cat fact with max length of "7" with status code 200
    Then Cat fact reponse should be empty
    And I send a request to get a cat fact with max length of "0" with status code 200
    Then Cat fact reponse should be empty
    And I send a request to get a cat fact with max length of "-5" with status code 200
    Then Cat fact reponse should be empty

  Scenario: Verify that cat fact API endpoint still returns a fact even with an incorrect value for max length
    Given I send a request to get a cat fact with max length of "-1a" with status code 200
    Then Cat fact response should not be empty
    And Cat fact response should contain the property "fact"
    And Cat fact response should contain the property "length"

  # Endpoint /facts

  Scenario: Verify that cat facts API endpoint returns correct number of items and a fact with a length less than or equal to the max length given
    Given I send a request to get cat facts with limit of "12" and max length of "20" with status code 200
    Then Count of cat facts should be less than or equal to 20
    And Length of all cat facts should be less than or equal to 20
    And I send a request to get cat facts with limit of "400" and max length of "400" with status code 200
    Then Count of cat facts should be less than or equal to 332
    And Length of all cat facts should be less than or equal to 400

  Scenario: Verify that cat facts API endpoint returns a default limit of 10 when limit parameter is empty
    Given I send a request to get cat facts with limit of "" and max length of "400" with status code 200
    Then Count of cat facts should be less than or equal to 10
    And Length of all cat facts should be less than or equal to 400
    And I send a request to get cat facts with limit of "" and max length of "" with status code 200
    Then Count of cat facts should be less than or equal to 10
    And Length of all cat facts should be less than or equal to 400

  Scenario: Verify that cat facts API endpoint returns a default limit of 10 and a random length of cat fact when given incorrect values for either parameter
    Given I send a request to get cat facts with limit of "a11" and max length of "" with status code 200
    Then Count of cat facts should be less than or equal to 10
    And Length of all cat facts should be less than or equal to 400
    And I send a request to get cat facts with limit of "-3" and max length of "400" with status code 200
    Then Count of cat facts should be less than or equal to 10
    And Length of all cat facts should be less than or equal to 400

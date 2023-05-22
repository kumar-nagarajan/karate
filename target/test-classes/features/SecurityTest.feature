@tokenValidation
Feature: Verify TEK Insurance Token
  Background: 
    * url "https://tek-insurance-api.azurewebsites.net"
    * def token = call read("GenerateToken.feature")
    * def tokenValue = token.response.token
    Then path "/api/token/verify"
  Scenario: Verify Valid Token
    * param token = tokenValue
    * param username = "supervisor"
    *  method get
    * status 200
    * print response
    And match response == "true"
  Scenario: Verify invalid username
    * param token = tokenValue
    * param username = "teacher"
    * method get
    * print response
    * status 400
    And match response.errorMessage == "Wrong Username send along with Token"
  Scenario: Verify invalid token with Valid userName
    * param token = "invalid value"
    * param username = "supervisor"
    * method get
    * print response
    * status 400
    And match response.errorMessage == "Token Expired or Invalid Token"
Feature: Get Request API Test 
   @test1
  Scenario: Get Account Test
    * url "https://tek-insurance-api.azurewebsites.net"
    * def token = call read("GenerateToken.feature")
    * def tokenValue = token.response.token
    * header Authorization = "Bearer " + tokenValue
    * path "/api/accounts/get-primary-account"
    * param primaryPersonId = "2631"
    * method get 
    * print response
    * status 200
    * def idValue = response.id
    * match idValue == 2631
    * match response.title == "Mr."
    * match response.firstName == "test"
    And match response.lastName == "tester"
    
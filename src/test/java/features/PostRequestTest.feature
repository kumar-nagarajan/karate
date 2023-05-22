@postrequest
Feature: Post Request Tests 
Background: 
	* url "https://tek-insurance-api.azurewebsites.net"
    * def token = call read("GenerateToken.feature")
    * def tokenValue = token.response.token
    * header Authorization = "Bearer " + tokenValue
	And path "api/accounts/add-primary-account" 
Scenario: Verify Post Request Method 
	And request 
		"""
      {
      "email":"karateCalli294@tekschool.com",
      "firstName":"Panthers",
      "lastName":"TEK",
      "title":"MR",
      "gender":"MALE",
      "maritalStatus":"SINGLE",
      "employmentStatus":"Student",
      "dateOfBirth": "1990-01-20"
      }
      """
	And method post 
	And status 201 
	And print response 

Scenario: post Request with Faker data 
#first we need to define a variable to read the java class
#second we need to define a variable to call each static method from that class
	* def generator = Java.type("api.test.DataGenerator")
    * def email = generator.getEmail()
    * def firstName = generator.getFirstName()
    * def lastName = generator.getLastName()
    * def dateOfBirth = generator.getDob()
    * def title = generator.getTitle()
	And request 
		"""
      {
      "email":"#(email)",
      "firstName":"#(firstName)",
      "lastName":"#(lastName)",
      "title":"#(title)",
      "gender":"MALE",
      "maritalStatus":"SINGLE",
      "employmentStatus":"Student",
      "dateOfBirth": "#(dateOfBirth)"
      }
      """
	And method post 
	And status 201 
	And print response 
	And match response.email == email 
	And match response.firstName == "#(firstName)" 
	And match response.lastName !=firstName
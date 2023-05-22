@schemaValidation
Feature: Get Request API Test 
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
	And match response == 
		"""
    {
  "id": '#number',
  "email": '#string',
  "title": "Mr.",
  "firstName": '#string',
  "lastName": '#string',
  "gender": '#string',
  "maritalStatus": '#string',
  "employmentStatus": '#string',
  "dateOfBirth": '#ignore',
  "user": null
     }
   """
   And def idValue = response.id
   And match idValue =='#number'

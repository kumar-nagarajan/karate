Feature: End to End Testing of API 
@e2e 
Scenario: end to end 
	* url "https://tek-insurance-api.azurewebsites.net"
    * def token = call read("GenerateToken.feature")
    * def tokenValue = token.response.token
    * header Authorization = "Bearer " + tokenValue
    * path "api/accounts/add-primary-account"
    * def generator = Java.type("api.test.DataGenerator")
    * def email = generator.getEmail()
    * def firstName = generator.getFirstName()
    * def lastName = generator.getLastName()
    * def dateOfBirth = generator.getDob()
    * def title = generator.getTitle()
    * def gender = generator.getGender()
    * def job = generator.getJob()
	And request 
		"""
      {
      "email":"#(email)",
      "firstName":"#(firstName)",
      "lastName":"#(lastName)",
      "title":"#(title)",
      "gender":"#(gender)",
     
      "employmentStatus":"#(job)",
      "dateOfBirth": "#(dateOfBirth)"
      }
      """
	And method post 
	And status 201 
	And print response.id 
	And match response.email == email 
	And match response.firstName == firstName 
	And match response.lastName == lastName 
	And match response.title == title 
	And match response.gender == gender 
	And match response.employmentStatus == job 
	And def dbresult = Java.type("api.test.DatabaseConnectionUtility") 
	And def dbemail = dbresult.result("select * from primary_person where id = '" + response.id +"'", "email" ) 
	And def dbFirstname = dbresult.result("select * from primary_person where id = '" + response.id +"'", "first_name" ) 
	And def dbLastName = dbresult.result("select * from primary_person where id = '" + response.id +"'", "last_name" ) 
	And def dbTitle = dbresult.result("select * from primary_person where id = '" + response.id +"'", "title" ) 
	And def dbGender = dbresult.result("select * from primary_person where id = '" + response.id +"'", "gender" ) 
	#And def dbMaritalStatus = dbresult.result("select * from primary_person where id = '" + response.id +"'", "marital_status" ) 
	And def dbEmpStatus = dbresult.result("select * from primary_person where id = '" + response.id +"'", "employment_status" ) 
	And def dbdateOfBirth = dbresult.result("select * from primary_person where id = '" + response.id +"'", "date_of_birth" ) 
	And match dbemail == email 
	And match dbFirstname == firstName 
	And match dbLastName == lastName 
	And match dbTitle == title 
	And match dbGender == gender 
 	And match dbEmpStatus == job 
	And match dbdateOfBirth contains dateOfBirth
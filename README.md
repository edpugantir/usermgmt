INTRODUCTION: This document explains how to run the User Registration REST API application developed using spring boot.
-------------


DEVELOPMENT ENVIRONMENT USED:
------------------------
Java Java 8
Spring boot version 2.2.0
MySql 8


DB SETUP:
---------
To setup the database and tables, please use basicsetup.sql in the 
root folder of the source code. This sql file creates a database with the name 'user_database'.
Creates an user 'userdbacc'.
Gives all previleges to the user 'userdbacc' on the database.
The password for 'userdbacc' is set to 'userdbacc'.


INSERTING SOME SAMPLE DATA:
---------------------------

IF NEEDED, script 'insert.sql' can be used to insert sample user data.


CONFIGURING PROPERTIES:
-----------------------
Configure the application.properties file located in the resources folder with the mysql 
database connection properties

spring.datasource.url=jdbc:mysql://<HOSTNAME>:3306/user_database?useSSL=false&serverTimeZone=UTC
spring.datasource.username=userdbacc
spring.datasource.password=userdbacc


CONFIGURING THE EMAIL PROPERTIES:
---------------------------------
Configure the application.properties file located in the resources folder with the mailing 
related properties. 

NOTE: Ensure that two stage security check is disabled in the gmail account.

spring.mail.host=smtp.gmail.com
spring.mail.port=587
spring.mail.username=<youremailaddress>
spring.mail.password=<yourpassword>

# Other properties
spring.mail.properties.mail.smtp.auth=true
spring.mail.properties.mail.smtp.connectiontimeout=5000
spring.mail.properties.mail.smtp.timeout=5000
spring.mail.properties.mail.smtp.writetimeout=5000

# TLS , port 587
spring.mail.properties.mail.smtp.starttls.enable=true


REST ENDPOINTS AND EXAMPLES:
----------------------------
IMPORTANT NOTE: 
--------------
All DELETE operations are soft deletes. That is we make them inactive and its NOT A HARD DELETE.

For invoked GET request for a specific user, we will not show the user, if he is inactive.
However, if the user is deleted and inactive, we STILL allow the UPDATE Operation on it.
Trying to delete an user who is already deleted and inactive we will not throw any exception.


for a single delete we use DELETE METHOD to conform to the rest specification.
for deleting multiple users there are many ways to implement

1) One can specify the ids of the volumes separated by , in the url of delete.
2) To take care of the multiple deletes at the client end by making multiple requests of single delete.
3) make a POSTrequest to a new uri with request body having details of the list of urls. I adopted this approach.

1.List of the existing registered users:

GET /api/users/
This returns only ACTIVE USERS.

Example:
GET at http://localhost:8080/api/users/

Returns:
	[
  	  {
  	      "id": 11,
 	      "firstName": "nagaraja",
    	      "lastName": "lakshman",
  	      "email": "nagarajal@xyz.com",
              "active": true
    },
    {
        "id": 12,
        "firstName": "jayant",
        "lastName": "patil",
        "email": "jayantp@xyz.com",
        "active": true
    }
]


GET /api/users/includeinactive=true
This will return ALL active AND inactive users.

Example:
GET at http://localhost:8080/api/users/

Returns:
	[
  	  {
  	      "id": 11,
 	      "firstName": "nagaraja",
    	      "lastName": "lakshman",
  	      "email": "nagarajal@xyz.com",
              "active": true
    	  },
    	  {
             "id": 12,
      	     "firstName": "jayant",
             "lastName": "patil",
             "email": "jayantp@xyz.com",
             "active": true
    	  },
	  {
   	     "id": 5,
    	     "firstName": "taran",
    	     "lastName": "adarsh",
	     "email": "tarana@xyz.com",
             "active": false
    	 }
	]


2. Show a specific registered user by passing the user ID. 
   

    GET at /api/users/{userid}

    Example:
	http://localhost:8080/api/users/11

    Returns:
	{
 	    "id": 11,
  	    "firstName": "nagaraja",
	    "lastName": "lakshman",
	    "email": "nagarajal@xyz.com",
	    "active": true
	}


3. Create a new registered user:
     POST at http://localhost:8080/api/users
     
     Example:
     POST at http://localhost:8080/api/users

     Body:
	{
	    "firstName":"mahindra",
	    "lastName":"agarwal",
	    "email":"mozillafirefoxacc@gmail.com"
	}

     Result:
	{
  	    "id": 14,
  	    "firstName": "vijay",
  	    "lastName": "kumar",
 	    "email": "mozillafirefoxacc@gmail.com",
  	    "active": true
	}


4. Update user information.
     PUT at /api/users

     Example:
     http://localhost:8080/api/users/1
    	{
   	    "id": 1,
       	    "firstName": "ravi",
    	    "lastName": "edpuganti",
     	    "email": "ravie@xyz.com",
     	    "active": true
   	 }


5. Delete single user
     DELETE at http://localhost:8080/api/users/{userId}

     Example:
		DELETE http://localhost:8080/api/users/10
     Result:
		Deactivated User with Id:11



6. Deactivate multiple users
     POST at  http://localhost:8080/api/users/deactivate

     BODY: list of user ids

     Example:
	POST http://localhost:8080/api/users/deactivate

	{
    	    "ids": [
        	    1,
        	    8,
        	    9,
        	    150
    	         ]
	}

     Result:
	{
    	"responses": [
   	     "User with ID:1:Successfully deactivated",
             "User with ID:8:Successfully deactivated",
    	     "User with ID:9:Successfully deactivated",
   	     "User with ID:150:not found in the system"
    	  ]
	}


PACKAGING AND RUNNING THE APPLICATION:
--------------------------------------

open windows command prompt
Go to the root directory of the source code.

1) RUN : mvnw.cmd package

NOTE: If you have maven installed, you can use: mvn package.

This creates a JAR file in the target subdirectory.

2) Go into target subdirectory and run the following command for running application.

java -jar usermgmt-0.0.1-SNAPSHOT.jar

3) You can also run the application by running the below command.

mvnw.cmd spring-boot:run



